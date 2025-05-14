import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/app_data/app_data_bloc.dart';
import 'package:nastya_diplom/application/selection/selection_bloc.dart';
import 'package:nastya_diplom/application/timer.dart';
import 'package:nastya_diplom/domain/data/test_data.dart';
import 'package:nastya_diplom/domain/test_4/test_4_models.dart';
import 'package:nastya_diplom/infrastructure/enum.dart';

part 'test_4_event.dart';

part 'test_4_state.dart';

class Test4Bloc extends Bloc<Test4Event, Test4State> {
  final AppDataBloc appBloc;
  final TimerService timer;

  Test4Bloc(this.appBloc)
      : timer = TimerService(),
        super(Test4State.initial()) {
    on<_SymbolSelected>(_onSymbolSelected);
    on<_Save>(_save);
    on<_Cancel>(_cancel);
  }

  Future<void> _onSymbolSelected(_SymbolSelected event, Emitter<Test4State> emit) async {
    if (state.isProcessing) return;

    emit(state.copyWith(
      isProcessing: true,
    ));

    final isCorrect = event.symbol == state.currentShape.symbol;
    final newErrorCount = isCorrect ? state.errorCount : state.errorCount + 1;

    emit(state.copyWith(
      selectedSymbol: event.symbol,
      errorCount: newErrorCount,
    ));

    await Future.delayed(const Duration(milliseconds: 800));

    ShapeType newType;
    final random = Random();
    do {
      newType = ShapeType.values[random.nextInt(5)];
    } while (newType == state.currentShape.type);

    final newShape = state.referenceShapes.firstWhere((s) => s.type == newType);

    emit(state.copyWith(
      currentStep: state.currentStep + 1,
      currentShape: newShape,
      selectedSymbol: null,
      isProcessing: false,
    ));
  }

  Future<void> _save(_Save event, Emitter<Test4State> emit) async {
    final duration = timer.duration;
    timer.dispose();
    appBloc.add(AppDataEvent.updateTest4Data(
      TestData(errorsCount: state.errorCount, duration: duration),
    ));
  }

  Future<void> _cancel(_Cancel event, Emitter<Test4State> emit) async {
    timer.dispose();
  }
}
