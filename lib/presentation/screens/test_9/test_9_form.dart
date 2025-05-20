part of 'test_9_screen.dart';

class Test9Form extends StatelessWidget {
  const Test9Form({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<Test9Bloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Тест на многозадачность'),
        leading: IconButton(
          onPressed: () {
            bloc.add(const Test9Event.cancel());
            context.router.replaceAll([SelectionRoute()]);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [TimerIndicator(timer: bloc.timer)],
      ),
      body: BlocListener<Test9Bloc, Test9State>(
        listenWhen: (p, c) => p.isCompleted != c.isCompleted,
        listener: (context, state) {
          if (state.isCompleted) {
            bloc.add(const Test9Event.save());
            context.router.replaceAll([
              SelectionRoute(initState: state.returnState),
            ]);
          }
        },
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            _AnimationPanel(),
            _MathProblemSection(),
            _ProgressIndicator(),
          ],
        ),
      ),
    );
  }
}


class _AnimationPanel extends StatelessWidget {
  const _AnimationPanel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Test9Bloc, Test9State>(
      buildWhen: (p, c) => p.circlePosition != c.circlePosition,
      builder: (context, state) {
        return SizedBox(
          height: 200,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 100),
                left: 20,
                right: 20,
                bottom: state.circlePosition * 117 + 21,
                child: const CircleAvatar(radius: 20),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MathProblemSection extends StatelessWidget {
  const _MathProblemSection();

  static final RegExInputFormatter _negativeLimitValidator =
  RegExInputFormatter.withRegex('^\$|^[0\\-]\$|^\\-\$|^\\-{0,1}[1-9][0-9]{0,9}?\$');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Test9Bloc, Test9State>(
      buildWhen: (p, c) => p.showCorrect != c.showCorrect || p.showError != c.showError,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                state.currentProblem.question,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: TextField(
                  keyboardType: TextInputType.number,
                  onSubmitted: (value) => context.read<Test9Bloc>().add(
                    Test9Event.answerSubmitted(int.tryParse(value) ?? 0),
                  ),
                  inputFormatters: [_negativeLimitValidator],
                  decoration: InputDecoration(
                    errorText: state.showError ? 'Неверный ответ' : null,
                    labelText: 'Поле для ответа',
                    border: const OutlineInputBorder(),
                    suffixIcon: state.showCorrect
                        ? const Icon(Icons.check, color: Colors.green)
                        : null,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Test9Bloc, Test9State>(
      buildWhen: (p, c) => p.progress != c.progress,
      builder: (context, state) {
        return LinearProgressIndicator(
          value: state.progress,
        );
      },
    );
  }
}
