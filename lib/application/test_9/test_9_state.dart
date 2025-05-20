part of 'test_9_bloc.dart';

class Test9State with EquatableMixin {
  final double circlePosition; // 0.0 - 1.0 (от нижней до верхней границы)
  final bool movingUp;
  final int bounceCount;
  final MathProblem currentProblem;
  final int? userAnswer;
  final int answeredCount;
  final bool showCorrect;
  final bool showError;
  final int errorsCount;

  const Test9State({
    required this.circlePosition,
    required this.movingUp,
    required this.bounceCount,
    required this.currentProblem,
    required this.userAnswer,
    required this.answeredCount,
    required this.showCorrect,
    required this.showError,
    required this.errorsCount,
  });

  factory Test9State.initial() {
    MathProblem firstProblem;
    do{
      firstProblem = _generateMathProblem(0);
    } while (firstProblem.type == MathProblemType.bounceCount);

    return Test9State(
      circlePosition: 0.0,
      movingUp: true,
      bounceCount: 0,
      currentProblem: firstProblem,
      userAnswer: null,
      answeredCount: 0,
      showCorrect: false,
      showError: false,
      errorsCount: 0
    );
  }

  static MathProblem _generateMathProblem(int bounceCount) {
    final type = MathProblemType.values.randomElement();
    return type.instance(bounceCount);
  }

  Test9State copyWith({
     double? circlePosition,
     bool? movingUp,
     int? bounceCount,
     MathProblem? currentProblem,
     int? userAnswer,
     int? answeredCount,
     bool? showCorrect,
     bool? showError,
    int? errorsCount,
  }) {
    return Test9State(
      circlePosition: circlePosition ?? this.circlePosition,
      movingUp: movingUp ?? this.movingUp,
      bounceCount: bounceCount ?? this.bounceCount,
      currentProblem: currentProblem ?? this.currentProblem,
      userAnswer: userAnswer ?? this.userAnswer,
      answeredCount: answeredCount ?? this.answeredCount,
      showCorrect: showCorrect ?? this.showCorrect,
      showError: showError ?? this.showError,
      errorsCount: errorsCount ?? this.errorsCount,
    );
  }

  @override
  List<Object?> get props => [
    circlePosition,
    movingUp,
    bounceCount,
    currentProblem,
    userAnswer,
    answeredCount,
    showCorrect,
    showError,
    errorsCount,
  ];
}

extension Test9StateX on Test9State {
  double get progress => answeredCount / 10;

  bool get isCompleted => answeredCount >= 10;

  SelectionState get returnState {
    return const SelectionState(testType: TestType.test9, showHistory: true);
  }
}
