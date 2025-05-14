part of 'test_5_bloc.dart';

List<DotCell> generateNewGrid(int targetDots) {
  final random = Random();
  final positions = List.generate(16, (i) => i)..shuffle(random);
  return List.generate(16, (index) => DotCell(shouldHaveDot: positions.take(targetDots).contains(index)));
}

class Test5State with EquatableMixin {
  final int currentStage;
  final List<DotCell> grid;
  final TestPhase phase;
  final int errorsCount;
  final int secondsFromLastPhase;

  const Test5State({
    required this.currentStage,
    required this.grid,
    required this.phase,
    required this.errorsCount,
    required this.secondsFromLastPhase,
  });

  factory Test5State.initial() {
    return Test5State(
      currentStage: 1,
      grid: generateNewGrid(2),
      phase: TestPhase.memorization,
      errorsCount: 0,
      secondsFromLastPhase: 0,
    );
  }

  Test5State copyWith({
    int? currentStage,
    List<DotCell>? grid,
    TestPhase? phase,
    int? errorsCount,
    int? secondsFromLastPhase,
  }) {
    return Test5State(
      currentStage: currentStage ?? this.currentStage,
      grid: grid ?? this.grid,
      phase: phase ?? this.phase,
      errorsCount: errorsCount ?? this.errorsCount,
      secondsFromLastPhase: secondsFromLastPhase ?? this.secondsFromLastPhase,
    );
  }

  @override
  List<Object?> get props => [
        currentStage,
        grid,
        phase,
        errorsCount,
        secondsFromLastPhase,
      ];
}

extension Test5StateX on Test5State {
  int get maxDots => 1 + currentStage;

  int get selectedDots {
    int res = 0;

    for (final cell in grid) {
      if (cell.hasDot) {
        res++;
      }
    }

    return res;
  }

  bool get canSelectDot => selectedDots < maxDots;

  bool get isCompleted => currentStage > 8;

  SelectionState get returnState {
    return const SelectionState(testType: TestType.test5, showHistory: true);
  }
}
