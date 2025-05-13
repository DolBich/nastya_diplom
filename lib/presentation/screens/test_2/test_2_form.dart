part of 'test_2_screen.dart';

class Test2Form extends StatelessWidget {
  const Test2Form({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<Test2Bloc>();
    final timer = bloc.timer;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Тест Шульте-Горбова (1 версия)'),
        leading: IconButton(
          onPressed: () {
            bloc.add(const Test2Event.cancel());
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
      body: BlocListener<Test2Bloc, Test2State>(
        listenWhen: (p, c) => p.isDone != c.isDone,
        listener: (context, state) {
          if (state.isDone) {
            bloc.add(const Test2Event.save());
            context.router.replaceAll([
              SelectionRoute(initState: state.returnState),
            ]);
          }
        },
        child: Center(
          child: SizedBox.square(
            dimension: 500,
            child: _Test2Grid(),
          ),
        ),
      ),
    );
  }
}

class _Test2Grid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Test2Bloc, Test2State>(
      builder: (context, state) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1.0,
          ),
          itemCount: 49,
          itemBuilder: (_, index) => _GridCell(index: index),
        );
      },
    );
  }
}

class _GridCell extends StatelessWidget {
  final int index;

  const _GridCell({required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<Test2Bloc, Test2State, Test2Cell>(
      selector: (state) => state.cells[index],
      builder: (context, cell) {
        Color? backgroundColor;
        if (cell.showError) {
          backgroundColor = Colors.red[100];
        } else if (cell.showCorrect) {
          backgroundColor = Colors.green[100];
        } else {
          backgroundColor = Colors.primaries[(cell.number ?? 1) % Colors.primaries.length].shade100;
        }

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextButton(
            onPressed: () {
              if (cell.number != null) {
                context.read<Test2Bloc>().add(Test2Event.cellTapped(cell));
              }
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: _CellContent(cell: cell),
          ),
        );
      },
    );
  }
}

class _CellContent extends StatelessWidget {
  final Test2Cell cell;

  const _CellContent({required this.cell});

  @override
  Widget build(BuildContext context) {
    if (cell.number == null) {
      return const Icon(Icons.remove_red_eye_outlined, size: 32);
    }

    Color? color = cell.showError ? Colors.red[900] : (cell.showCorrect ? Colors.green[900] : Colors.black);

    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 200),
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: cell.showCorrect || cell.showError ? 18 : 16,
      ),
      child: Text('${cell.number}'),
    );
  }
}
