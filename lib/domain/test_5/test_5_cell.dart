import 'package:equatable/equatable.dart';

enum TestPhase { memorization, placement, results }

extension TestPhaseTime on TestPhase {
  Duration get duration {
    switch (this) {
      case TestPhase.memorization:
        return const Duration(seconds: 2);
      case TestPhase.placement:
        return const Duration(seconds: 15);
      case TestPhase.results:
        return const Duration(seconds: 5);
    }
  }

  TestPhase get nextPhase {
    switch (this) {
      case TestPhase.memorization:
        return TestPhase.placement;
      case TestPhase.placement:
        return TestPhase.results;
      case TestPhase.results:
        return TestPhase.memorization;
    }
  }

  int get sumTime {
    int res = 0;
    TestPhase.values.map((e) => res = res + e.duration.inSeconds);
    return res;
  }
}

class DotCell with EquatableMixin {
  final bool hasDot;
  final bool shouldHaveDot;

  const DotCell({
    this.hasDot = false,
    this.shouldHaveDot = false,
  });
  DotCell copyWith({
    bool? hasDot,
    bool? shouldHaveDot,
  }) {
    return DotCell(
      hasDot: hasDot ?? this.hasDot,
      shouldHaveDot: shouldHaveDot ?? this.shouldHaveDot,
    );
  }

  @override
  List<Object?> get props => [hasDot, shouldHaveDot];
}

extension DotCellGetters on DotCell {
  bool get isMissed => !hasDot && shouldHaveDot;

  bool get right => hasDot && shouldHaveDot;

  bool get wrong => hasDot && !shouldHaveDot;
}