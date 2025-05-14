part of 'test_4_bloc.dart';

class Test4State with EquatableMixin {
  final List<ShapeSymbol> referenceShapes;
  final ShapeSymbol currentShape;
  final int currentStep;
  final int errorCount;
  final IconData? selectedSymbol;
  final bool isProcessing;

  const Test4State({
    required this.referenceShapes,
    required this.currentShape,
    required this.currentStep,
    required this.errorCount,
    this.selectedSymbol,
    required this.isProcessing,
  });

  factory Test4State.initial() {
    final symbols = [Icons.add, Icons.remove, Icons.drag_handle, Icons.check, Icons.close];
    final referenceShapes = ShapeType.values
        .map((type) => ShapeSymbol(
              type: type,
              symbol: symbols[type.index],
            ))
        .toList();

    return Test4State(
      referenceShapes: referenceShapes,
      currentShape: referenceShapes.first,
      currentStep: 0,
      errorCount: 0,
      isProcessing: false,
    );
  }

  Test4State copyWith({
    List<ShapeSymbol>? referenceShapes,
    ShapeSymbol? currentShape,
    ShapeSymbol? prevSymbol,
    int? currentStep,
    int? errorCount,
    IconData? selectedSymbol,
    bool? isProcessing,
  }) {
    return Test4State(
      referenceShapes: referenceShapes ?? this.referenceShapes,
      currentShape: currentShape ?? this.currentShape,
      errorCount: errorCount ?? this.errorCount,
      currentStep: currentStep ?? this.currentStep,
      isProcessing: isProcessing ?? this.isProcessing,
      selectedSymbol: selectedSymbol,
    );
  }

  @override
  List<Object?> get props => [
        referenceShapes,
        currentShape,
        errorCount,
        currentStep,
        selectedSymbol,
        isProcessing,
      ];
}

extension Test4StateX on Test4State {
  bool get isCompleted => currentStep > 99;

  SelectionState get returnState {
    return const SelectionState(testType: TestType.test4, showHistory: true);
  }
}
