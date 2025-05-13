part of 'profile_bloc.dart';

sealed class ProfileEvent {
  const ProfileEvent();

  const factory ProfileEvent.updateBirthDate(DateTime date) = _UpdateBirthDate;

  const factory ProfileEvent.updateName(String name) = _UpdateName;

  const factory ProfileEvent.updateSurname(String surname) = _UpdateSurname;

  const factory ProfileEvent.save() = _Save;

}

class _Save extends ProfileEvent {
  const _Save();
}

class _UpdateSurname extends ProfileEvent {
  final String surname;
  const _UpdateSurname(this.surname);
}

class _UpdateName extends ProfileEvent {
  final String name;
  const _UpdateName(this.name);
}

class _UpdateBirthDate extends ProfileEvent {
  final DateTime date;
  const _UpdateBirthDate(this.date);
}
