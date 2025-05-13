import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable(explicitToJson: true)
class Profile with EquatableMixin {
  final DateTime birthDate;
  final String name;
  final String surname;

  const Profile({
    required this.name,
    required this.surname,
    required this.birthDate,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  @override
  List<Object?> get props => [
        birthDate,
        name,
        surname,
      ];
}
