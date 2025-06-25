import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'custom_event.dart';
part 'custom_state.dart';

class CustomBloc extends Bloc<CustomEvent, CustomState> {
  CustomBloc() : super(CustomState.initial()) {
    on<_ButtonPushed>(_buttonPushed);
    on<_Refresh>(_refresh);
    on<_ChangePreview>(_changePreview);
    on<_Save>(_save);
  }

  Future<void> _buttonPushed(_ButtonPushed event, Emitter<CustomState> emit) async {
    emit(state.copyWith(
      count: state.count + 1,
    ));
  }

  Future<void> _save(_Save event, Emitter<CustomState> emit) async {
    emit(state.copyWith(
      isPreview: !state.isPreview,
      initialCount: state.count,
    ));
  }

  Future<void> _refresh(_Refresh event, Emitter<CustomState> emit) async {
    emit(state.copyWith(
      isRefreshing: true,
    ));

    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(
      isRefreshing: false,
      count: state.initialCount,
    ));
  }

  Future<void> _changePreview(_ChangePreview event, Emitter<CustomState> emit) async {
    emit(state.copyWith(
      isPreview: !state.isPreview,
      count: state.initialCount,
    ));
  }
}