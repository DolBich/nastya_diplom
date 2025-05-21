part of 'test_7_screen.dart';

class Test7Form extends StatelessWidget {
  const Test7Form({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<Test7Bloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.timer.start();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(TestType.test7.title),
        leading: IconButton(
          onPressed: () {
            bloc.add(const Test7Event.cancel());
            context.router.replaceAll([SelectionRoute()]);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocListener<Test7Bloc, Test7State>(
        listenWhen: (p, c) => p.isCompleted != c.isCompleted || p.shouldNavigate != c.shouldNavigate,
        listener: (context, state) {
          if (state.isCompleted || state.shouldNavigate) {
            bloc.add(const Test7Event.save());
            context.router.replaceAll([
              SelectionRoute(initState: state.returnState),
            ]);
          }
        },
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            _ProgressBars(),
            Test7ImageWidget(),
            _AnswerButtons(),
          ],
        ),
      ),
    );
  }
}

class Test7ImageWidget extends StatelessWidget {
  const Test7ImageWidget({super.key});

  Widget get _mainState {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Соответствует ли этот символ показанному 2-мя шагами ранее',
          style: TextStyle(fontSize: 20),
        ),
        BlocBuilder<Test7Bloc, Test7State>(
          buildWhen: (p, c) => p.currentIndex != c.currentIndex || p.images != c.images,
          builder: (context, state) {
            final image = state.currentImage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: _getBackgroundColor(image),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(24),
              child: Icon(
                image.type.getIcon,
                size: 100,
                color: _getIconColor(image),
              ),
            );
          },
        )
      ],
    );
  }

  Widget _firstState(BuildContext context) {
    final bloc = context.read<Test7Bloc>();
    final images = bloc.state.images;

    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Это начало ряда символов, которые надо запомнить (первый тот, что слева)',
          style: TextStyle(fontSize: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 40,
          children: List.generate(2, (i) {
            return Icon(
              images[i].type.getIcon,
              size: 100,
            );
          }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Test7Bloc, Test7State>(
      buildWhen: (p, c) => p.firstStage != c.firstStage,
      builder: (context, state) {
        if (state.firstStage) return _firstState(context);
        return _mainState;
      },
    );
  }
}

Color _getBackgroundColor(Test7Image image) {
  if (image.showCorrect) return Colors.green.withOpacity(0.3);
  if (image.showError) return Colors.red.withOpacity(0.3);
  return Colors.transparent;
}

Color _getIconColor(Test7Image image) {
  if (image.showCorrect || image.showError) return Colors.white38;
  return Colors.black26;
}

class _AnswerButtons extends StatelessWidget {
  const _AnswerButtons();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<Test7Bloc, Test7State, bool>(
      selector: (state) => state.firstStage,
      builder: (context, firstStage) {
        if (firstStage) return const SizedBox();

        final bloc = context.read<Test7Bloc>();
        return Row(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              onPressed: () => bloc.add(const Test7Event.isEqual(true)),
              child: const Text('Да', style: TextStyle(fontSize: 24, color: Colors.green)),
            ),
            TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              onPressed: () => bloc.add(const Test7Event.isEqual(false)),
              child: const Text('Нет', style: TextStyle(fontSize: 24, color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}

class _ProgressBars extends StatelessWidget {
  const _ProgressBars();

  Widget get _timer {
    return BlocSelector<Test7Bloc, Test7State, int>(
      selector: (state) => state.remainingTime,
      builder: (context, remainingTime) {
        return Text(
          'Осталось: ${remainingTime ~/ 60}:${(remainingTime % 60).toString().padLeft(2, '0')}',
          style: Theme.of(context).textTheme.titleMedium,
        );
      },
    );
  }

  Widget get _timeProgress {
    return BlocSelector<Test7Bloc, Test7State, double>(
      selector: (state) => state.timeProgress,
      builder: (context, timeProgress) {
        return LinearProgressIndicator(
          value: timeProgress,
          minHeight: 10,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(
            Color.lerp(Colors.red, Colors.green, timeProgress)!,
          ),
        );
      },
    );
  }

  Widget get _questionsProgress {
    return BlocSelector<Test7Bloc, Test7State, double>(
      selector: (state) => state.questionsProgress,
      builder: (context, questionsProgress) {
        return LinearProgressIndicator(
          value: questionsProgress,
          minHeight: 10,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Test7Bloc, Test7State>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 8,
            children: [
              _timeProgress,
              _questionsProgress,
              _timer,
            ],
          ),
        );
      },
    );
  }
}
