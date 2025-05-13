import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/app_data/app_data_bloc.dart';
import 'package:nastya_diplom/application/selection/selection_bloc.dart';
import 'package:nastya_diplom/application/timer.dart';
import 'package:nastya_diplom/domain/data/test_data.dart';
import 'package:nastya_diplom/domain/test_3/test_3_cell.dart';
import 'package:nastya_diplom/infrastructure/enum.dart';

part 'test_3_event.dart';
part 'test_3_state.dart';

class Test3Bloc extends Bloc<Test3Event, Test3State> {
  final AppDataBloc appBloc;
  final TimerService timer;

  Test3Bloc(this.appBloc)
      : timer = TimerService(),
        super(Test3State.initial()) {
    on<_CellTapped>(_onCellTapped);
    on<_Save>(_save);
    on<_Cancel>(_cancel);
  }

  Future<void> _onCellTapped(_CellTapped event, Emitter<Test3State> emit) async {
    if(state.isProcessing) return;

    emit(state.copyWith(
      isProcessing: true,
    ));

    final cell = event.cell;

    bool isCorrect = false;

    if (state.isBlackTurn) {
      isCorrect = cell.isBlack && cell.number == state.currentBlack;
    } else {
      isCorrect = !cell.isBlack && cell.number == state.currentRed && (state.currentBlack + cell.number == 25);
    }

    final newCells = List<Test3Cell>.from(state.cells);
    final index = newCells.indexWhere((e) => e == cell);

    newCells[index] = cell.copyWith(
      showCorrect: isCorrect,
      showError: !isCorrect,
    );

    emit(state.copyWith(
      cells: newCells,
      errorCount: isCorrect ? state.errorCount : state.errorCount + 1,
    ));

    await Future.delayed(const Duration(milliseconds: 300));

    if (isCorrect) {
      newCells[index] = cell.copyWith(
        showCorrect: false,
      );

      if (state.isBlackTurn && cell.number != 25) {
        emit(state.copyWith(
          cells: newCells,
          isBlackTurn: false,
        ));
      } else {
        emit(state.copyWith(
          cells: newCells,
          currentBlack: state.currentBlack - 1,
          currentRed: state.currentRed + 1,
          isBlackTurn: true,
        ));
      }
    } else {
      final newCells = List<Test3Cell>.from(state.cells);
      newCells[index] = cell.copyWith(showError: false);
      emit(state.copyWith(
        cells: newCells,
      ));
    }

    emit(state.copyWith(
      isProcessing: false,
    ));
  }

  Future<void> _save(_Save event, Emitter<Test3State> emit) async {
    final duration = timer.duration;
    timer.dispose();
    appBloc.add(AppDataEvent.updateTest3Data(
      TestData(errorsCount: state.errorCount, duration: duration),
    ));
  }

  Future<void> _cancel(_Cancel event, Emitter<Test3State> emit) async {
    timer.dispose();
  }
}
