// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestData _$TestDataFromJson(Map<String, dynamic> json) => TestData(
      errorsCount: (json['errorsCount'] as num).toInt(),
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
    );

Map<String, dynamic> _$TestDataToJson(TestData instance) => <String, dynamic>{
      'errorsCount': instance.errorsCount,
      'duration': instance.duration.inMicroseconds,
    };
