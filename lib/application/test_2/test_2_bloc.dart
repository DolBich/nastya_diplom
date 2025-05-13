import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/app_data/app_data_bloc.dart';
import 'package:nastya_diplom/application/selection/selection_bloc.dart';
import 'package:nastya_diplom/application/timer.dart';
import 'package:nastya_diplom/domain/data/test_data.dart';
import 'package:nastya_diplom/domain/test_2/cell.dart';
import 'package:nastya_diplom/infrastructure/enum.dart';

part 'test_2_event.dart';

part 'test_2_state.dart';

class Test2Bloc extends Bloc<Test2Event, Test2State> {
  final AppDataBloc appBloc;
  final TimerService timer;

  Test2Bloc(this.appBloc)
      : timer = TimerService(),
        super(Test2State.initial()) {
    on<_CellTapped>(_onCellTapped);
    on<_Save>(_save);
    on<_Cancel>(_cancel);
  }

  Future<void> _onCellTapped(_CellTapped event, Emitter<Test2State> emit) async {
    final cell = event.cell;
    if (cell.number == null) return;

    final isCorrect = cell.number == state.currentNumber;
    final newErrorCount = isCorrect ? state.errorCount : state.errorCount + 1;

    final newCells = List<Test2Cell>.from(state.cells);
    final index = newCells.indexWhere((e) => e.number == cell.number);
    newCells[index] = cell.copyWith(showError: !isCorrect, showCorrect: isCorrect);

    emit(state.copyWith(
      cells: newCells,
      errorCount: newErrorCount,
      currentNumber: isCorrect ? state.currentNumber + 1 : null,
    ));

    await Future.delayed(const Duration(milliseconds: 300));

    final updatedCells = List<Test2Cell>.from(newCells);
    updatedCells[index] = cell.copyWith(showError: false, showCorrect: false);

    emit(state.copyWith(
      cells: updatedCells,
    ));
  }

  Future<void> _save(_Save event, Emitter<Test2State> emit) async {
    final duration = timer.duration;
    timer.dispose();
    appBloc.add(AppDataEvent.updateTest2Data(
      TestData(errorsCount: state.errorCount, duration: duration),
    ));
  }

  Future<void> _cancel(_Cancel event, Emitter<Test2State> emit) async {
    timer.dispose();
  }
}
