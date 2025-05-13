// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryUnit _$HistoryUnitFromJson(Map<String, dynamic> json) => HistoryUnit(
      data: TestData.fromJson(json['data'] as Map<String, dynamic>),
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$HistoryUnitToJson(HistoryUnit instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
      'date': instance.date.toIso8601String(),
    };
