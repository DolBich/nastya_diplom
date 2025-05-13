part of 'test_3_bloc.dart';

class Test3State with EquatableMixin {
  final List<Test3Cell> cells;
  final int currentBlack;
  final int currentRed;
  final int errorCount;
  final bool isBlackTurn;
  final bool isProcessing;

  const Test3State({
    required this.cells,
    required this.currentBlack,
    required this.currentRed,
    required this.errorCount,
    required this.isBlackTurn,
    required this.isProcessing,
  });

  factory Test3State.initial() {
    final blackNumbers = List.generate(25, (i) => i + 1)..sort((a, b) => b.compareTo(a));
    final redNumbers = List.generate(24, (i) => i + 1);

    final cells = <Test3Cell>[];

    for (final num in blackNumbers) {
      cells.add(Test3Cell(number: num, isBlack: true));
    }

    for (final num in redNumbers) {
      cells.add(Test3Cell(number: num, isBlack: false));
    }

    cells.shuffle();

    return Test3State(
      cells: cells,
      currentBlack: 25,
      currentRed: 0,
      errorCount: 0,
      isBlackTurn: true,
      isProcessing: false,
    );
  }

  Test3State copyWith({
    List<Test3Cell>? cells,
    int? currentBlack,
    int? currentRed,
    int? errorCount,
    bool? isBlackTurn,
    bool? isProcessing,
  }) {
    return Test3State(
      cells: cells ?? this.cells,
      currentBlack: currentBlack ?? this.currentBlack,
      currentRed: currentRed ?? this.currentRed,
      errorCount: errorCount ?? this.errorCount,
      isBlackTurn: isBlackTurn ?? this.isBlackTurn,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }

  @override
  List<Object?> get props => [cells, currentBlack, currentRed, errorCount, isBlackTurn, isProcessing];
}

extension Test3StateX on Test3State {
  bool get isCompleted => currentBlack < 1;

  SelectionState get returnState {
    return const SelectionState(testType: TestType.test3, showHistory: true);
  }
}