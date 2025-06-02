import 'dart:math';

import 'package:equatable/equatable.dart';

enum MathProblemType {
  addition,
  subtraction,
  multiplication,
  division,
  bounceCount,
}

extension MathProblemTypeX on MathProblemType {
  MathProblem instance(int bounceCount) {
    final random = Random();
    switch (this) {
      case MathProblemType.addition:
        final a = random.nextInt(50);
        final b = random.nextInt(50);
        return MathProblem(
          question: '$a + $b = ?',
          correctAnswer: a + b,
          type: MathProblemType.addition,
        );
      case MathProblemType.subtraction:
        final a = random.nextInt(50);
        final b = random.nextInt(50);
        return MathProblem(
          question: '$a - $b = ?',
          correctAnswer: a - b,
          type: MathProblemType.subtraction,
        );
      case MathProblemType.multiplication:
        final a = random.nextInt(10);
        final b = random.nextInt(10);
        return MathProblem(
          question: '$a * $b = ?',
          correctAnswer: a * b,
          type: MathProblemType.multiplication,
        );
      case MathProblemType.division:
        final a = 10 + random.nextInt(50);
        final b = 1 + random.nextInt(9);
        return MathProblem(
          question: '$a / $b = ? (Ответ целое число в нижнюю сторону)',
          correctAnswer: a ~/ b,
          type: MathProblemType.division,
        );
      case MathProblemType.bounceCount:
        return MathProblem(
          question: 'Сколько раз уже отскочил шар от границ квадрата?',
          correctAnswer: bounceCount,
          type: MathProblemType.bounceCount,
        );
    }
  }
}

class MathProblem with EquatableMixin {
  final String question;
  final int correctAnswer;
  final MathProblemType type;

  MathProblem({
    required this.question,
    required this.correctAnswer,
    required this.type,
  });

  @override
  List<Object?> get props => [question, correctAnswer, type];
}
