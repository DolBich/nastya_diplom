part of 'test_1_bloc.dart';

class Test1State with EquatableMixin {
  final List<GridNumber> targets;
  final List<GridNumber> grid;
  final int errorCount;

  const Test1State({
    required this.targets,
    required this.grid,
    required this.errorCount,
  });

  factory Test1State.initial() {
    final random = Random();
    final targetsSet = <int>{};

    while (targetsSet.length < 5) {
      targetsSet.add(100 + random.nextInt(899));
    }

    final nonTargets = <int>{};
    while (nonTargets.length < 95) {
      final number = 100 + random.nextInt(899);
      if (!targetsSet.contains(number)) {
        nonTargets.add(number);
      }
    }

    final combined = [
      ...targetsSet.map((n) => GridNumber(value: n, isTarget: true)),
      ...nonTargets.map((n) => GridNumber(value: n, isTarget: false)),
    ]..shuffle();

    return Test1State(
      targets: targetsSet
          .map((n) => GridNumber(value: n, isTarget: true))
          .toList(),
      grid: combined,
      errorCount: 0,
    );
  }

  Test1State copyWith({
    List<GridNumber>? targets,
    List<GridNumber>? grid,
    int? errorCount,
  }) {
    return Test1State(
      targets: targets ?? this.targets,
      grid: grid ?? this.grid,
      errorCount: errorCount ?? this.errorCount,
    );
  }

  @override
  List<Object?> get props =>  [targets, grid, errorCount];
}

extension Test1StateX on Test1State {
  List<GridNumber> get remainTargets {
    final List<GridNumber> res = [];
    for (final target in targets) {
      if(!target.isFound) {
        res.add(target);
      }
    }
    return res;
  }

  SelectionState get returnState {
    return const SelectionState(testType: TestType.test1, showHistory: true);
  }
}