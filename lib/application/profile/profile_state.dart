part of 'profile_bloc.dart';

class ProfileState with EquatableMixin {
  final DateTime? birthDate;
  final String? name;
  final String? surname;

  const ProfileState({
    this.birthDate,
    this.name,
    this.surname,
  });

  factory ProfileState.initial(Profile? profile) {
    return ProfileState(
      birthDate: profile?.birthDate,
      name: profile?.name,
      surname: profile?.surname,
    );
  }

  ProfileState copyWith({
    DateTime? birthDate,
    String? name,
    String? surname,
  }) {
    return ProfileState(
      birthDate: birthDate ?? this.birthDate,
      name: name ?? this.name,
      surname: surname ?? this.surname,
    );
  }

  @override
  List<Object?> get props => [
        birthDate,
        name,
        surname,
      ];
}

extension ProfileStateX on ProfileState {
  Profile? get profile {
    final name = this.name;
    final surname = this.surname;
    final birthDate = this.birthDate;

    if(name != null && surname != null && birthDate != null) {
      return Profile(
        name: name,
        surname: surname,
        birthDate: birthDate,
      );
    }
    return null;
  }

  bool get enableSave {
    final name = this.name;
    final surname = this.surname;
    final birthDate = this.birthDate;

    return name != null && name.isNotEmpty && surname != null && surname.isNotEmpty && birthDate != null;
  }
}
