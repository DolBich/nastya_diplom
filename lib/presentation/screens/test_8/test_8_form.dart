part of 'test_8_screen.dart';

class Test8Form extends StatelessWidget {
  const Test8Form({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<Test8Bloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.add(const Test8Event.init());
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(TestType.test8.title),
        leading: IconButton(
          onPressed: () {
            bloc.add(const Test8Event.cancel());
            context.router.replaceAll([SelectionRoute()]);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocListener<Test8Bloc, Test8State>(
        listenWhen: (p, c) => p.isCompleted != c.isCompleted,
        listener: (context, state) {
          if (state.isCompleted) {
            bloc.add(const Test8Event.save());
            context.router.replaceAll([
              SelectionRoute(initState: state.returnState),
            ]);
          }
        },
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            _TimerProgress(),
            Expanded(
              child: Center(
                child: _MainInteractionButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimerProgress extends StatelessWidget {
  const _TimerProgress();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Test8Bloc, Test8State>(
      buildWhen: (p, c) => p.remainingTime != c.remainingTime,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              LinearProgressIndicator(
                value: state.timeProgress,
                minHeight: 10,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color.lerp(Colors.red, Colors.green, state.timeProgress)!,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Осталось времени: ${state.remainingTime ~/ 60}:${(state.remainingTime % 60).toString().padLeft(2, '0')}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MainInteractionButton extends StatefulWidget {
  const _MainInteractionButton();

  @override
  State<_MainInteractionButton> createState() => _MainInteractionButtonState();
}

class _MainInteractionButtonState extends State<_MainInteractionButton> {
  int prevErrorsCount = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Test8Bloc, Test8State>(
      buildWhen: (p, c) => p.showFeedback != c.showFeedback,
      builder: (context, state) {
        final bloc = context.read<Test8Bloc>();
        final isError = state.errorsCount > prevErrorsCount && state.showFeedback;

        if(isError) {
          prevErrorsCount = state.errorsCount;
        }

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: state.showFeedback
                ? (isError ? Colors.red : Colors.green)
                : Colors.blue,
            shape: BoxShape.circle,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () => bloc.add(const Test8Event.buttonPressed()),
              child: const Icon(
                Icons.volume_up,
                size: 60,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}