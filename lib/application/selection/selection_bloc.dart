import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/infrastructure/enum.dart';

part 'selection_event.dart';
part 'selection_state.dart';

class SelectionBloc extends Bloc<SelectionEvent, SelectionState> {
  SelectionBloc() : super(SelectionState.initial()){
    on<_UpdateShowHistory>(_updateShowHistory);
    on<_UpdateTestType>(_updateTestType);
    on<_Reset>(_reset);
  }

  Future<void> _reset(_Reset event, Emitter<SelectionState> emit) async {
    emit(event.updatedState);
  }

  Future<void> _updateShowHistory(_UpdateShowHistory event, Emitter<SelectionState> emit) async {
    emit(state.copyWith(
      showHistory: !state.showHistory,
    ));
  }

  Future<void> _updateTestType(_UpdateTestType event, Emitter<SelectionState> emit) async {
    emit(state.copyWith(
      testType: event.type,
    ));
  }
}