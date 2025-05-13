import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/app_data/app_data_bloc.dart';
import 'package:nastya_diplom/application/selection/selection_bloc.dart';
import 'package:nastya_diplom/application/timer.dart';
import 'package:nastya_diplom/domain/data/test_data.dart';
import 'package:nastya_diplom/domain/test_1/numbers.dart';
import 'package:nastya_diplom/infrastructure/enum.dart';

part 'test_1_event.dart';

part 'test_1_state.dart';

class Test1Bloc extends Bloc<Test1Event, Test1State> {
  final AppDataBloc appBloc;
  final TimerService timer;

  Test1Bloc(this.appBloc)
      : timer = TimerService(),
        super(Test1State.initial()) {
    on<_TargetFound>(_targetFound);
    on<_Save>(_save);
    on<_Cancel>(_cancel);
    on<_Error>(_error);
  }

  Future<void> _targetFound(_TargetFound event, Emitter<Test1State> emit) async {
    List<GridNumber> targets = List.from(state.targets);
    targets = targets
        .map((e) => e.value == event.target.value
            ? GridNumber(
                value: e.value,
                isTarget: true,
                isFound: true,
              )
            : e)
        .toList();

    List<GridNumber> grid = List.from(state.grid);
    grid = grid
        .map((e) => e.value == event.target.value
            ? GridNumber(
                value: e.value,
                isTarget: true,
                isFound: true,
              )
            : e)

        .toList();
    emit(state.copyWith(
      targets: targets,
      grid: grid,
    ));
  }

  Future<void> _save(_Save event, Emitter<Test1State> emit) async {
    final duration = timer.duration;
    timer.dispose();
    appBloc.add(AppDataEvent.updateTest1Data(
      TestData(errorsCount: state.errorCount, duration: duration),
    ));
  }

  Future<void> _cancel(_Cancel event, Emitter<Test1State> emit) async {
    timer.dispose();
  }

  Future<void> _error(_Error event, Emitter<Test1State> emit) async {
    emit(state.copyWith(
      errorCount: state.errorCount + 1,
    ));
  }
}
