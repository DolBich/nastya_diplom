import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/app_data/app_data_bloc.dart';
import 'package:nastya_diplom/application/app_history/app_history_bloc.dart';
import 'package:nastya_diplom/domain/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AppDataBloc appBloc;

  ProfileBloc(this.appBloc) : super(ProfileState.initial(appBloc.historyBloc.state.profile)){
    on<_UpdateBirthDate>(_updateBirthDate);
    on<_UpdateName>(_updateName);
    on<_UpdateSurname>(_updateSurname);
    on<_Save>(_save);
  }

  Future<void> _save(_Save event, Emitter<ProfileState> emit) async {
    final profile = state.profile;
    if(profile != null) {
      appBloc.historyBloc.add(AppHistoryEvent.updateProfile(profile));
    }
  }

  Future<void> _updateSurname(_UpdateSurname event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(
      surname: event.surname,
    ));
  }

  Future<void> _updateName(_UpdateName event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(
      name: event.name,
    ));
  }

  Future<void> _updateBirthDate(_UpdateBirthDate event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(
      birthDate: event.date,
    ));
  }
}