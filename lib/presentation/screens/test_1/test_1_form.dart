part of 'test_1_screen.dart';

class Test1Form extends StatelessWidget {
  const Test1Form({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<Test1Bloc>();
    final timer = bloc.timer;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Тест Торндайка'),
        leading: IconButton(
          onPressed: () {
            bloc.add(const Test1Event.cancel());
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
      body: BlocListener<Test1Bloc, Test1State>(
        listenWhen: (p, c) => !listEquals(p.remainTargets, c.remainTargets) && c.remainTargets.isEmpty,
        listener: (context, state) {
          bloc.add(const Test1Event.save());
          context.router.replaceAll([
            SelectionRoute(initState: state.returnState),
          ]);
        },
        child: Column(
          children: [
            const _TargetNumbersPanel(),
            SizedBox.square(
              dimension: 500,
              child: _NumberGrid(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TargetNumbersPanel extends StatelessWidget {
  const _TargetNumbersPanel();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<Test1Bloc>();
    final targets = bloc.state.targets;
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          targets.length,
          (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: _NumberCell(
                index: index,
                inGrid: false,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _NumberGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<Test1Bloc>();
    final grid = bloc.state.grid;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 10,
      ),
      itemCount: grid.length,
      itemBuilder: (_, index) => _NumberCell(
        index: index,
        inGrid: true,
      ),
    );
  }
}

class _NumberCell extends StatelessWidget {
  final bool inGrid;
  final int index;

  const _NumberCell({required this.inGrid, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Test1Bloc, Test1State>(
      buildWhen: (p, c) => inGrid ? (p.grid[index] != c.grid[index]) : (p.targets[index] != c.targets[index]),
      builder: (context, state) {
        final GridNumber number = inGrid ? state.grid[index] : state.targets[index];

        final text = Text(
          number.value.toString(),
          style: TextStyle(
            color: number.isFound ? Colors.blue : Colors.black,
            fontWeight: !inGrid ? FontWeight.bold : FontWeight.normal,
          ),
        );

        return inGrid
            ? TextButton(
                onPressed: !number.isFound
                    ? () {
                        final bloc = context.read<Test1Bloc>();
                        if (number.isTarget) {
                          bloc.add(Test1Event.targetFound(number));
                        } else {
                          bloc.add(const Test1Event.error());
                        }
                      }
                    : null,
                child: text,
              )
            : text;
      },
    );
  }
}
