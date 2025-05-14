part of 'test_4_screen.dart';

class Test4Form extends StatelessWidget {
  const Test4Form({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<Test4Bloc>();
    final timer = bloc.timer;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Тест Пьерона-Рузера'),
        leading: IconButton(
          onPressed: () {
            bloc.add(const Test4Event.cancel());
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
      body: BlocListener<Test4Bloc, Test4State>(
        listenWhen: (p, c) => p.isCompleted != c.isCompleted,
        listener: (context, state) {
          if (state.isCompleted) {
            bloc.add(const Test4Event.save());
            context.router.replaceAll([
              SelectionRoute(initState: state.returnState),
            ]);
          }
        },
        child: const Column(
          spacing: 25,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _ReferenceShapesPanel(),
            _TargetShape(),
            _SymbolButtons(),
            _ProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class _ReferenceShapesPanel extends StatelessWidget {
  const _ReferenceShapesPanel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Test4Bloc, Test4State>(
      buildWhen: (p, c) => p.referenceShapes != c.referenceShapes,
      builder: (context, state) {
        final shapes = state.referenceShapes;
        return SizedBox(
          height: 100,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(shapes.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: _ShapeWithSymbol(
                    shape: shapes[index],
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

class _ShapeWithSymbol extends StatelessWidget {
  final ShapeSymbol shape;

  const _ShapeWithSymbol({required this.shape});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        _ShapeWidget(type: shape.type),
        Icon(shape.symbol, size: 25),
      ],
    );
  }
}

class _TargetShape extends StatelessWidget {
  const _TargetShape();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Test4Bloc, Test4State>(
      buildWhen: (p, c) => p.currentShape != c.currentShape,
      builder: (context, state) {
        return SizedBox(
          width: 100,
          height: 100,
          child: Center(
            child: _ShapeWidget(type: state.currentShape.type, size: 100,),
          ),
        );
      },
    );
  }
}

class _ShapeWidget extends StatelessWidget {
  final ShapeType type;
  final double size;

  const _ShapeWidget({required this.type,this.size = 48});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ShapeType.star:
        return Icon(Icons.star_outline, size: size);
      case ShapeType.circle:
        return Icon(Icons.circle_outlined, size: size);
      case ShapeType.triangle:
        return Icon(Icons.change_history, size: size);
      case ShapeType.heart:
        return Icon(Icons.favorite_border_outlined, size: size);
      case ShapeType.square:
        return Icon(Icons.square_outlined, size: size);
    }
  }
}


class _SymbolButtons extends StatelessWidget {
  const _SymbolButtons();

  @override
  Widget build(BuildContext context) {
    final symbols = [Icons.drag_handle, Icons.remove, Icons.add, Icons.close, Icons.check];

    return BlocBuilder<Test4Bloc, Test4State>(
      buildWhen: (p, c) => p.selectedSymbol != c.selectedSymbol || p.currentShape != c.currentShape,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: symbols.map((symbol) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: _getButtonColor(symbol, state),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                onPressed: () {
                  final bloc = context.read<Test4Bloc>();
                  bloc.add(Test4Event.symbolSelected(symbol));
                },
                icon: Icon(symbol),
              ),
            );
          }).toList(),
        );
      },
    );
  }


  Color? _getButtonColor(IconData symbol, Test4State state) {
    if (state.selectedSymbol != symbol) return Colors.transparent;

    return symbol == state.currentShape.symbol
        ? Colors.green[100]
        : Colors.red[100];
  }
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Test4Bloc, Test4State>(
      buildWhen: (p, c) => p.currentStep != c.currentStep,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: LinearProgressIndicator(
            value: state.currentStep / 100,
            minHeight: 8,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.purple),
          ),
        );
      },
    );
  }
}