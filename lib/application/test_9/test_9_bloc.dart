import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/app_data/app_data_bloc.dart';
import 'package:nastya_diplom/application/selection/selection_bloc.dart';
import 'package:nastya_diplom/application/timer.dart';
import 'package:nastya_diplom/domain/data/test_data.dart';
import 'package:nastya_diplom/domain/iterable_ext.dart';
import 'package:nastya_diplom/domain/test_9/math_problem.dart';
import 'package:nastya_diplom/infrastructure/enum.dart';

part 'test_9_event.dart';

part 'test_9_state.dart';

class Test9Bloc extends Bloc<Test9Event, Test9State> {
  final AppDataBloc appBloc;
  bool _animationPaused = false;
  final TimerService timer;

  Test9Bloc(this.appBloc)
      :  timer = TimerService(),
        super(Test9State.initial()) {
    on<_UpdatePosition>(_updatePosition);
    on<_AnswerSubmitted>(_answerSubmitted);
    on<_Save>(_save);
    on<_Cancel>(_cancel);
    on<_PauseAnimation>(_pauseAnimation);
    on<_ResumeAnimation>(_resumeAnimation);

    timer.timerStream.listen((_) {
      if (!_animationPaused) add(const Test9Event.updatePosition());
    });
  }

  Future<void> _updatePosition(_UpdatePosition event, Emitter<Test9State> emit) async {
    final newPosition = state.circlePosition + (state.movingUp ? 0.06 : -0.06);
    var newBounceCount = state.bounceCount;
    var newDirection = state.movingUp;

    if (newPosition >= 1.0 || newPosition <= 0.0) {
      newDirection = !newDirection;
      newBounceCount++;
    }

    emit(state.copyWith(
      circlePosition: newPosition.clamp(0.0, 1.0),
      movingUp: newDirection,
      bounceCount: newBounceCount,
    ));
  }

  Future<void> _answerSubmitted(_AnswerSubmitted event, Emitter<Test9State> emit) async {
    if (state.isCompleted) return;
    if(_animationPaused) add(const Test9Event.resumeAnimation());

    final isCorrect = event.answer == state.currentProblem.correctAnswer;
    final newAnsweredCount = state.answeredCount + 1;

    // Обновление состояния с визуальной обратной связью
    emit(state.copyWith(
      userAnswer: event.answer,
      showCorrect: isCorrect,
      showError: !isCorrect,
      errorsCount: !isCorrect ? state.errorsCount + 1 : null,
      answeredCount: newAnsweredCount,
    ));

    await Future.delayed(const Duration(milliseconds: 500));

    if (newAnsweredCount >= 10) {
      add(const Test9Event.save());
    } else {
      final newProblem = Test9State._generateMathProblem(state.bounceCount);
      final shouldPause = newProblem.type == MathProblemType.bounceCount;

      emit(state.copyWith(
        currentProblem: newProblem,
        userAnswer: null,
        showCorrect: false,
        showError: false,
      ));

      if (shouldPause) add(const Test9Event.pauseAnimation());
    }
  }

  Future<void> _pauseAnimation(_PauseAnimation event, Emitter<Test9State> emit) async {
    _animationPaused = true;
  }

  Future<void> _resumeAnimation(_ResumeAnimation event, Emitter<Test9State> emit) async {
    _animationPaused = false;
  }

  Future<void> _save(_Save event, Emitter<Test9State> emit) async {
    final duration = timer.duration;
    timer.dispose();

    appBloc.add(AppDataEvent.updateTest9Data(
      TestData(errorsCount: state.errorsCount, duration: duration),
    ));
  }

  Future<void> _cancel(_Cancel event, Emitter<Test9State> emit) async {
    timer.dispose();
  }
}
