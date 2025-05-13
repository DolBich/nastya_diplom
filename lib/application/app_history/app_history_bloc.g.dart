// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_history_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppHistoryState _$AppHistoryStateFromJson(Map<String, dynamic> json) =>
    AppHistoryState(
      profile: json['profile'] == null
          ? null
          : Profile.fromJson(json['profile'] as Map<String, dynamic>),
      test1dataHistory: (json['test1dataHistory'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$TestTypeEnumMap, k),
            (e as List<dynamic>?)
                ?.map((e) => HistoryUnit.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      test2dataHistory: (json['test2dataHistory'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$TestTypeEnumMap, k),
            (e as List<dynamic>?)
                ?.map((e) => HistoryUnit.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      test3dataHistory: (json['test3dataHistory'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$TestTypeEnumMap, k),
            (e as List<dynamic>?)
                ?.map((e) => HistoryUnit.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      test4dataHistory: (json['test4dataHistory'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$TestTypeEnumMap, k),
            (e as List<dynamic>?)
                ?.map((e) => HistoryUnit.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      test5dataHistory: (json['test5dataHistory'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$TestTypeEnumMap, k),
            (e as List<dynamic>?)
                ?.map((e) => HistoryUnit.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      test6dataHistory: (json['test6dataHistory'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$TestTypeEnumMap, k),
            (e as List<dynamic>?)
                ?.map((e) => HistoryUnit.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      test7dataHistory: (json['test7dataHistory'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$TestTypeEnumMap, k),
            (e as List<dynamic>?)
                ?.map((e) => HistoryUnit.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      test8dataHistory: (json['test8dataHistory'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$TestTypeEnumMap, k),
            (e as List<dynamic>?)
                ?.map((e) => HistoryUnit.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      test9dataHistory: (json['test9dataHistory'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$TestTypeEnumMap, k),
            (e as List<dynamic>?)
                ?.map((e) => HistoryUnit.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$AppHistoryStateToJson(AppHistoryState instance) =>
    <String, dynamic>{
      'profile': instance.profile?.toJson(),
      'test1dataHistory': instance.test1dataHistory.map((k, e) =>
          MapEntry(_$TestTypeEnumMap[k]!, e?.map((e) => e.toJson()).toList())),
      'test2dataHistory': instance.test2dataHistory.map((k, e) =>
          MapEntry(_$TestTypeEnumMap[k]!, e?.map((e) => e.toJson()).toList())),
      'test3dataHistory': instance.test3dataHistory.map((k, e) =>
          MapEntry(_$TestTypeEnumMap[k]!, e?.map((e) => e.toJson()).toList())),
      'test4dataHistory': instance.test4dataHistory.map((k, e) =>
          MapEntry(_$TestTypeEnumMap[k]!, e?.map((e) => e.toJson()).toList())),
      'test5dataHistory': instance.test5dataHistory.map((k, e) =>
          MapEntry(_$TestTypeEnumMap[k]!, e?.map((e) => e.toJson()).toList())),
      'test6dataHistory': instance.test6dataHistory.map((k, e) =>
          MapEntry(_$TestTypeEnumMap[k]!, e?.map((e) => e.toJson()).toList())),
      'test7dataHistory': instance.test7dataHistory.map((k, e) =>
          MapEntry(_$TestTypeEnumMap[k]!, e?.map((e) => e.toJson()).toList())),
      'test8dataHistory': instance.test8dataHistory.map((k, e) =>
          MapEntry(_$TestTypeEnumMap[k]!, e?.map((e) => e.toJson()).toList())),
      'test9dataHistory': instance.test9dataHistory.map((k, e) =>
          MapEntry(_$TestTypeEnumMap[k]!, e?.map((e) => e.toJson()).toList())),
    };

const _$TestTypeEnumMap = {
  TestType.test1: 'test1',
  TestType.test2: 'test2',
  TestType.test3: 'test3',
  TestType.test4: 'test4',
  TestType.test5: 'test5',
  TestType.test6: 'test6',
  TestType.test7: 'test7',
  TestType.test8: 'test8',
  TestType.test9: 'test9',
};
