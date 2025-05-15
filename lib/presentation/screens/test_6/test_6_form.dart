part of 'test_6_screen.dart';

class Test6Form extends StatelessWidget {
  const Test6Form({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<Test6Bloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.timer.start();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Тест "Перепутанные линии"'),
        leading: IconButton(
          onPressed: () {
            bloc.add(const Test6Event.cancel());
            context.router.replaceAll([SelectionRoute()]);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: const _FloatingControlButton(),
      body: BlocListener<Test6Bloc, Test6State>(
        listenWhen: (p, c) => p.shouldNavigate != c.shouldNavigate,
        listener: (context, state) {
          if (state.shouldNavigate) {
            context.router.replaceAll([SelectionRoute()]);
          }
        },
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _TimerPanel(),
            Expanded(child: _MainContent()),
          ],
        ),
      ),
    );
  }
}

class _MainContent extends StatelessWidget {
  const _MainContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Test6Bloc, Test6State>(
      buildWhen: (prev, curr) => prev.isCompleted != curr.isCompleted,
      builder: (context, state) {
        return ListView(
          children: const [
            _LinesGrid(),
          ],
        );
      },
    );
  }
}

class _LinesGrid extends StatelessWidget {
  const _LinesGrid();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _NumberColumn(isLeft: true),
        SizedBox(
          width: 500,
          child: BlocBuilder<Test6Bloc, Test6State>(
              buildWhen: (p, c) => p.isCursorVisible != c.isCursorVisible || p.isCompleted != c.isCompleted,
              builder: (context, state) {
                final showCursor = state.isCompleted || state.isCursorVisible;
                return MouseRegion(
                  cursor: showCursor ? MouseCursor.defer : SystemMouseCursors.none,
                  onEnter: (_) {
                    context.read<Test6Bloc>().add(const Test6Event.toggleCursor());
                  },
                  onExit: (_) {
                    context.read<Test6Bloc>().add(const Test6Event.toggleCursor());
                  },
                  child: BlocBuilder<Test6Bloc, Test6State>(
                      buildWhen: (p, c) => p.lines != c.lines || p.isCompleted != c.isCompleted,
                      builder: (context, state) {
                        return CustomPaint(
                          size: const Size(500, 25 * 25),
                          painter: _LinesPainter(lines: state.lines, isCompleted: state.isCompleted),
                        );
                      }),
                );
              }),
        ),
        const _NumberColumn(isLeft: false),
      ],
    );
  }
}

class _LinesPainter extends CustomPainter {
  final List<ConnectionLine> lines;
  final bool isCompleted;

  const _LinesPainter({required this.lines, required this.isCompleted});

  @override
  void paint(Canvas canvas, Size size) {
    final defaultPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (final line in lines) {
      _configPaint(defaultPaint, line);

      canvas.drawPath(line.path, defaultPaint);
    }
  }

  void _configPaint(Paint paint, ConnectionLine line) {
    if (!isCompleted) {
      return;
    }
    if (line.isError) {
      paint.color = Colors.red;
    } else {
      paint.color = Colors.green;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _NumberColumn extends StatelessWidget {
  final bool isLeft;

  const _NumberColumn({required this.isLeft});

  Widget _intForm(BuildContext context, int rightIndex) {
    final bloc = context.read<Test6Bloc>();
    return SizedBox(
      height: 25,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: BlocTextFieldInt<Test6Bloc, Test6State>(
          bloc: bloc,
          decoration: const InputDecoration(isDense: true, border: InputBorder.none),
          stateValue: (state) {
            return state.lines.firstWhere((e) => e.rightIndex == rightIndex + 1).answer;
          },
          onChanged: (v) => bloc.add(Test6Event.updateAnswer(rightIndex: rightIndex + 1, answer: (v ?? 0))),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: Column(
        children: List.generate(25, (i) {
          return Container(
            height: 25,
            alignment: Alignment.center,
            // margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
            ),
            child: isLeft ? Text('${i + 1}') : _intForm(context, i),
          );
        }),
      ),
    );
  }
}

class _TimerPanel extends StatelessWidget {
  const _TimerPanel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Test6Bloc, Test6State>(
      buildWhen: (p, c) => p.remainingTime != c.remainingTime || p.isCompleted != c.isCompleted,
      builder: (context, state) {
        final remaining = state.remainingTime;
        final minutes = (remaining ~/ 60).toString().padLeft(2, '0');
        final seconds = (remaining % 60).toString().padLeft(2, '0');
        final progress = remaining / (7 * 60);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getProgressColor(progress),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Осталось времени:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: state.isCompleted
                        ? const Text(
                            'Завершено',
                            style: TextStyle(color: Colors.green),
                          )
                        : Text(
                            '$minutes:$seconds',
                            style: TextStyle(
                              color: _getTimeColor(remaining),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getProgressColor(double progress) {
    return Color.lerp(
      Colors.red,
      Colors.green,
      progress,
    )!;
  }

  Color _getTimeColor(int remaining) {
    if (remaining > 120) return Colors.green;
    if (remaining > 60) return Colors.orange;
    return Colors.red;
  }
}

class _FloatingControlButton extends StatelessWidget {
  const _FloatingControlButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Test6Bloc, Test6State>(
      builder: (context, state) {
        return FloatingActionButton.extended(
          onPressed: () =>
              context.read<Test6Bloc>().add(state.isCompleted ? const Test6Event.save() : const Test6Event.complete()),
          label: Text(state.isCompleted ? 'Продолжить' : 'Завершить'),
          icon: Icon(state.isCompleted ? Icons.arrow_forward : Icons.check),
        );
      },
    );
  }
}
