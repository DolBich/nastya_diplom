part of 'test_3_screen.dart';

class Test3Form extends StatelessWidget {
  const Test3Form({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<Test3Bloc>();
    final timer = bloc.timer;

    return Scaffold(
      appBar: AppBar(
        title: Text(TestType.test3.title, style: const TextStyle(fontSize: DEFAULT_TEXT_SIZE),),
        leading: IconButton(
          onPressed: () {
            bloc.add(const Test3Event.cancel());
            context.router.replaceAll([SelectionRoute()]);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          TimerIndicator(
            timer: timer,
          ),
        ],
      ),
      body: BlocListener<Test3Bloc, Test3State>(
        listenWhen: (p, c) => p.isCompleted != c.isCompleted,
        listener: (context, state) {
          if (state.isCompleted) {
            bloc.add(const Test3Event.save());
            context.router.replaceAll([
              SelectionRoute(initState: state.returnState),
            ]);
          }
        },
        child: Center(
          child: SizedBox.square(
            dimension: 500,
            child:  _Test3Grid(),
          ),
        ),
      ),
    );
  }
}

class _Test3Grid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: 1,
        ),
        itemCount: 49,
        itemBuilder: (context, index) => _GridCell(index: index),
      ),
    );
  }
}

class _GridCell extends StatelessWidget {
  final int index;

  const _GridCell({required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<Test3Bloc, Test3State, Test3Cell>(
      selector: (state) => state.cells[index],
      builder: (context, cell) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: _getCellColor(cell),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _getBorderColor(cell),
              width: cell.showError || cell.showCorrect ? 2 : 1,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => context.read<Test3Bloc>().add(Test3Event.cellTapped(cell)),
              child: Center(
                child: Text(
                  cell.number.toString(),
                  style: TextStyle(
                    color:_getTextColor(cell),
                    fontSize: DEFAULT_TEXT_SIZE,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getTextColor(Test3Cell cell) {
    return cell.isBlack ? Colors.black : Colors.red;
  }

  Color _getCellColor(Test3Cell cell) {
    if (cell.showError) return Colors.red.withOpacity(0.3);
    if (cell.showCorrect) return Colors.green.withOpacity(0.3);
    return Colors.white;
  }

  Color _getBorderColor(Test3Cell cell) {
    if (cell.showError) return Colors.red;
    if (cell.showCorrect) return Colors.green;
    return Colors.white;
  }
}
