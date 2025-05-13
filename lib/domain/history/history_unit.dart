import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nastya_diplom/domain/data/test_data.dart';

part 'history_unit.g.dart';

@JsonSerializable(explicitToJson: true)
class HistoryUnit with EquatableMixin {
  final TestData data;
  final DateTime date;

  const HistoryUnit({
    required this.data,
    required this.date,
  });

  factory HistoryUnit.fromJson(Map<String, dynamic> json) => _$HistoryUnitFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryUnitToJson(this);

  @override
  List<Object?> get props => [
    data,
    date,
  ];
}