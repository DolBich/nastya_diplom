import 'dart:math';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/app_data/app_data_bloc.dart';
import 'package:nastya_diplom/application/selection/selection_bloc.dart';
import 'package:nastya_diplom/application/timer.dart';
import 'package:nastya_diplom/domain/data/test_data.dart';
import 'package:nastya_diplom/domain/test_6/test_6_unit.dart';
import 'package:nastya_diplom/infrastructure/enum.dart';

part 'test_6_event.dart';

part 'test_6_state.dart';

class Test6Bloc extends Bloc<Test6Event, Test6State> {
  final AppDataBloc appBloc;
  final TimerService timer;

  Test6Bloc(this.appBloc)
      : timer = TimerService(),
        super(Test6State.initial()) {
    on<_UpdateAnswer>(_updateAnswer);
    on<_Save>(_save);
    on<_Cancel>(_cancel);
    on<_ToggleCursor>(_onToggleCursor);
    on<_UpdateRemainingTime>(_updateRemainingTime);
    on<_Complete>(_complete);

    timer.timerStream.listen((duration) {
      add(const Test6Event.updateRemainingTime());
    });
  }

  Future<void> _updateAnswer(_UpdateAnswer event, Emitter<Test6State> emit) async {
    final updatedLines = List<ConnectionLine>.from(state.lines);
    final lineIndex = updatedLines.indexWhere((line) => line.rightIndex == event.rightIndex);

    if (lineIndex == -1) return;

    updatedLines[lineIndex] = updatedLines[lineIndex].copyWith(
      answer: event.answer,
    );

    emit(state.copyWith(
      lines: updatedLines,
    ));
  }

  Future<void> _onToggleCursor(_ToggleCursor event, Emitter<Test6State> emit) async {
    emit(state.copyWith(
      isCursorVisible: !state.isCursorVisible,
    ));
  }

  Future<void> _updateRemainingTime(_UpdateRemainingTime event, Emitter<Test6State> emit) async {
    final updatedTime = 7*60 - timer.duration.inSeconds;
    if(updatedTime <= 0) {
      add(const Test6Event.complete());
    }
    emit(state.copyWith(
      remainingTime: updatedTime,
    ));
  }

  Future<void> _complete(_Complete event, Emitter<Test6State> emit) async {
    final errors = state.errors;

    final duration = timer.duration;
    timer.dispose();
    appBloc.add(AppDataEvent.updateTest6Data(
      TestData(errorsCount: errors, duration: duration),
    ));

    emit(state.copyWith(
      isCompleted: true,
    ));
  }

  Future<void> _save(_Save event, Emitter<Test6State> emit) async {
    emit(state.copyWith(shouldNavigate: true));
  }

  Future<void> _cancel(_Cancel event, Emitter<Test6State> emit) async {
    timer.dispose();
  }
}
