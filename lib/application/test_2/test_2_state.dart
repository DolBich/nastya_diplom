part of 'test_2_bloc.dart';

class Test2State with EquatableMixin {
  final List<Test2Cell> cells;
  final int currentNumber;
  final int errorCount;


  const Test2State({
    required this.cells,
    required this.currentNumber,
    required this.errorCount,
  });

  factory Test2State.initial() {
    final numbers = List.generate(48, (i) => i + 1)..shuffle();
    final cells = <Test2Cell>[];

    int index = 0;
    for (int i = 0; i < 49; i++) {
      if (i == 24) {
        cells.add(Test2Cell(number: null));
      } else {
        cells.add(Test2Cell(number: numbers[index++]));
      }
    }

    return Test2State(
      cells: cells,
      currentNumber: 1,
      errorCount: 0,
    );
  }

  Test2State copyWith({
    List<Test2Cell>? cells,
    int? currentNumber,
    int? errorCount,
  }) {
    return Test2State(
      cells: cells ?? this.cells,
      currentNumber: currentNumber ?? this.currentNumber,
      errorCount: errorCount ?? this.errorCount,
    );
  }

  @override
  List<Object?> get props =>  [cells, currentNumber, errorCount];
}

extension Test2StateX on Test2State {
  bool get isDone {
    for(final number in cells) {
      if((number.number ?? 0) >= currentNumber) {
        return false;
      }
    }
    return true;
  }

  SelectionState get returnState {
    return const SelectionState(testType: TestType.test2, showHistory: true);
  }
}