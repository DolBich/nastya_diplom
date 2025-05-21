part of 'test_5_screen.dart';

class Test5Form extends StatelessWidget {
  const Test5Form({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<Test5Bloc>();
    final timer = bloc.timer;

    return Scaffold(
      appBar: AppBar(
        title: Text(TestType.test5.title),
        leading: IconButton(
          onPressed: () {
            bloc.add(const Test5Event.cancel());
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
      body: BlocListener<Test5Bloc, Test5State>(
        listenWhen: (p, c) => p.isCompleted != c.isCompleted,
        listener: (context, state) {
          if (state.isCompleted) {
            bloc.add(const Test5Event.save());
            context.router.replaceAll([
              SelectionRoute(initState: state.returnState),
            ]);
          }
        },
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _PhaseIndicator(),
              _Grids(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhaseIndicator extends StatefulWidget {
  const _PhaseIndicator();

  @override
  State<_PhaseIndicator> createState() => _PhaseIndicatorState();
}

class _PhaseIndicatorState extends State<_PhaseIndicator> {
  int remainingSeconds = 0;

  @override
  void initState() {
    final bloc = context.read<Test5Bloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.timer.timerStream.listen((duration) {
        final state = bloc.state;
        final timeSpent = duration.inSeconds - state.secondsFromLastPhase;
        final res = state.phase.duration.inSeconds - timeSpent;
        if ((res - remainingSeconds).abs() >= 1) {
          setState(() {
            remainingSeconds = res;
          });
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Test5Bloc, Test5State>(
      listenWhen: (p, c) => p.canSelectDot != c.canSelectDot || p.phase != c.phase,
      listener: (context, state) {
        if (!state.canSelectDot && state.phase == TestPhase.placement) {
          context.read<Test5Bloc>().add(const Test5Event.nextPhase());
        }
      },
      buildWhen: (p, c) => p.secondsFromLastPhase != c.secondsFromLastPhase,
      builder: (context, state) {
        return Column(
          children: [
            Text(
              _getPhaseTitle(state.phase),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: remainingSeconds / state.phase.duration.inSeconds,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                _getPhaseColor(state.phase),
              ),
            ),
            Text(
              'Осталось: ${remainingSeconds.clamp(0, state.phase.duration.inSeconds)} сек',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        );
      },
    );
  }

  String _getPhaseTitle(TestPhase phase) {
    return switch (phase) {
      TestPhase.memorization => 'Запоминайте расположение точек',
      TestPhase.placement => 'Расставьте точки',
      TestPhase.results => 'Результаты',
    };
  }

  Color _getPhaseColor(TestPhase phase) {
    return switch (phase) {
      TestPhase.memorization => Colors.blue,
      TestPhase.placement => Colors.orange,
      TestPhase.results => Colors.purple,
    };
  }
}

class _Grids extends StatelessWidget {
  const _Grids();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Test5Bloc, Test5State>(
      buildWhen: (p, c) => p.grid != c.grid || p.phase != c.phase,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            _Grid(
              isUpper: true,
              cells: state.grid,
              showDots: state.phase == TestPhase.memorization || state.phase == TestPhase.results,
            ),
            _Grid(
              isUpper: false,
              cells: state.grid,
              isActive: state.phase == TestPhase.placement,
              showDots: state.phase == TestPhase.results || state.phase == TestPhase.placement,
              showResults: state.phase == TestPhase.results,
            ),
          ],
        );
      },
    );
  }
}

class _Grid extends StatelessWidget {
  final bool isUpper;
  final List<DotCell> cells;
  final bool showDots;
  final bool isActive;
  final bool showResults;

  const _Grid({
    required this.isUpper,
    required this.cells,
    required this.showDots,
    this.isActive = false,
    this.showResults = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 300,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
        ),
        itemCount: 16,
        itemBuilder: (context, index) => _GridCell(
          isUpper: isUpper,
          cell: cells[index],
          showDots: showDots,
          index: index,
          isActive: isActive,
          showResults: showResults,
        ),
      ),
    );
  }
}

class _GridCell extends StatelessWidget {
  final bool showDots;
  final bool isUpper;
  final DotCell cell;
  final int index;
  final bool isActive;
  final bool showResults;

  const _GridCell({
    required this.isUpper,
    required this.cell,
    required this.index,
    required this.showDots,
    required this.isActive,
    required this.showResults,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => isActive && !isUpper ? context.read<Test5Bloc>().add(Test5Event.dotSelected(index)) : null,
      child: Container(
        decoration: BoxDecoration(
          color: !isUpper ? _getCellColor() : null,
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: _buildDot(),
        ),
      ),
    );
  }

  Color? _getCellColor() {
    if (!showResults) return null;

    if (cell.right) return Colors.green.withOpacity(0.3);
    if (cell.wrong) return Colors.red.withOpacity(0.3);
    if (cell.isMissed) return Colors.black.withOpacity(0.1);
    return null;
  }

  Widget? _buildDot() {
    if((isUpper && showDots && cell.shouldHaveDot) || (!isUpper && showDots && (cell.hasDot || cell.isMissed && showResults)))
    {
      return Icon(
        Icons.circle,
        size: 20,
        color: showResults && !isUpper ? _getResultColor() : Colors.black,
      );
    }
    return null;
  }

  Color _getResultColor() {
    if (cell.right) return Colors.green;
    if (cell.wrong) return Colors.red;
    if (cell.isMissed) return Colors.black26;
    return Colors.black;
  }
}
