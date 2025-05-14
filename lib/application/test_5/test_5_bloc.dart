import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/app_data/app_data_bloc.dart';
import 'package:nastya_diplom/application/selection/selection_bloc.dart';
import 'package:nastya_diplom/application/timer.dart';
import 'package:nastya_diplom/domain/data/test_data.dart';
import 'package:nastya_diplom/domain/test_5/test_5_cell.dart';
import 'package:nastya_diplom/infrastructure/enum.dart';

part 'test_5_event.dart';

part 'test_5_state.dart';

class Test5Bloc extends Bloc<Test5Event, Test5State> {
  final AppDataBloc appBloc;
  final TimerService timer;

  Test5Bloc(this.appBloc)
      : timer = TimerService(),
        super(Test5State.initial()) {
    on<_DotSelected>(_onDotSelected);
    on<_NextPhase>(_onNextPhase);
    on<_Save>(_save);
    on<_Cancel>(_cancel);

    timer.timerStream.listen((duration) {
      if (state.phase.duration.inSeconds <= duration.inSeconds - state.secondsFromLastPhase) {
        add(const Test5Event.nextPhase());
      }
    });
  }
  
  Future<void> _onNextPhase(_NextPhase event, Emitter<Test5State> emit) async {
    if(state.phase.nextPhase == TestPhase.results) {
      int errors = state.maxDots - state.grid.where((e) => e.right).length;
      emit(state.copyWith(
        errorsCount: state.errorsCount + errors,
      ));
    }
    if(state.phase.nextPhase == TestPhase.memorization) {
      emit(state.copyWith(
        currentStage: state.currentStage + 1,
        grid: generateNewGrid(state.maxDots + 1),
      ));
    }

    emit(state.copyWith(
      phase: state.phase.nextPhase,
      secondsFromLastPhase: timer.duration.inSeconds,
    ));
  }

  Future<void> _onDotSelected(_DotSelected event, Emitter<Test5State> emit) async {
    if(state.phase != TestPhase.placement) return;
    if(!state.canSelectDot) return;

    final List<DotCell> updatedDots = List.from(state.grid);
    DotCell dot = updatedDots[event.dotIndex];

    if(dot.hasDot) return;

    dot = dot.copyWith(hasDot: true);
    updatedDots[event.dotIndex] = dot;

    emit(state.copyWith(
      grid: updatedDots,
    ));
  }

  Future<void> _save(_Save event, Emitter<Test5State> emit) async {
    final duration = timer.duration;
    timer.dispose();
    appBloc.add(AppDataEvent.updateTest5Data(
      TestData(errorsCount: state.errorsCount, duration: duration),
    ));
  }

  Future<void> _cancel(_Cancel event, Emitter<Test5State> emit) async {
    timer.dispose();
  }
}
