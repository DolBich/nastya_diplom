part of 'app_history_bloc.dart';

@JsonSerializable(explicitToJson: true)
class AppHistoryState with EquatableMixin {
  final Profile? profile;

  final Map<TestType, List<HistoryUnit>?> test1dataHistory;
  final Map<TestType, List<HistoryUnit>?> test2dataHistory;
  final Map<TestType, List<HistoryUnit>?> test3dataHistory;
  final Map<TestType, List<HistoryUnit>?> test4dataHistory;
  final Map<TestType, List<HistoryUnit>?> test5dataHistory;
  final Map<TestType, List<HistoryUnit>?> test6dataHistory;
  final Map<TestType, List<HistoryUnit>?> test7dataHistory;
  final Map<TestType, List<HistoryUnit>?> test8dataHistory;
  final Map<TestType, List<HistoryUnit>?> test9dataHistory;

  const AppHistoryState({
    this.profile,
    required this.test1dataHistory,
    required this.test2dataHistory,
    required this.test3dataHistory,
    required this.test4dataHistory,
    required this.test5dataHistory,
    required this.test6dataHistory,
    required this.test7dataHistory,
    required this.test8dataHistory,
    required this.test9dataHistory,
  });

  factory AppHistoryState.initial(Map<String, dynamic>? json) {
    if (json != null) {
      return AppHistoryState.fromJson(json);
    }
    return AppHistoryState(
      test1dataHistory: Map.fromEntries([const MapEntry(TestType.test1, null)]),
      test2dataHistory: Map.fromEntries([const MapEntry(TestType.test2, null)]),
      test3dataHistory: Map.fromEntries([const MapEntry(TestType.test3, null)]),
      test4dataHistory: Map.fromEntries([const MapEntry(TestType.test4, null)]),
      test5dataHistory: Map.fromEntries([const MapEntry(TestType.test5, null)]),
      test6dataHistory: Map.fromEntries([const MapEntry(TestType.test6, null)]),
      test7dataHistory: Map.fromEntries([const MapEntry(TestType.test7, null)]),
      test8dataHistory: Map.fromEntries([const MapEntry(TestType.test8, null)]),
      test9dataHistory: Map.fromEntries([const MapEntry(TestType.test9, null)]),
    );
  }

  AppHistoryState copyWith({
    Profile? profile,
    List<HistoryUnit>? test1dataHistory,
    List<HistoryUnit>? test2dataHistory,
    List<HistoryUnit>? test3dataHistory,
    List<HistoryUnit>? test4dataHistory,
    List<HistoryUnit>? test5dataHistory,
    List<HistoryUnit>? test6dataHistory,
    List<HistoryUnit>? test7dataHistory,
    List<HistoryUnit>? test8dataHistory,
    List<HistoryUnit>? test9dataHistory,
  }) {
    return AppHistoryState(
      profile: profile ?? this.profile,
      test1dataHistory: Map.fromEntries([MapEntry(this.test1dataHistory.keys.first, test1dataHistory ?? this.test1dataHistory.values.first)]),
      test2dataHistory: Map.fromEntries([MapEntry(this.test2dataHistory.keys.first, test2dataHistory ?? this.test2dataHistory.values.first)]),
      test3dataHistory: Map.fromEntries([MapEntry(this.test3dataHistory.keys.first, test3dataHistory ?? this.test3dataHistory.values.first)]),
      test4dataHistory: Map.fromEntries([MapEntry(this.test4dataHistory.keys.first, test4dataHistory ?? this.test4dataHistory.values.first)]),
      test5dataHistory: Map.fromEntries([MapEntry(this.test5dataHistory.keys.first, test5dataHistory ?? this.test5dataHistory.values.first)]),
      test6dataHistory: Map.fromEntries([MapEntry(this.test6dataHistory.keys.first, test6dataHistory ?? this.test6dataHistory.values.first)]),
      test7dataHistory: Map.fromEntries([MapEntry(this.test7dataHistory.keys.first, test7dataHistory ?? this.test7dataHistory.values.first)]),
      test8dataHistory: Map.fromEntries([MapEntry(this.test8dataHistory.keys.first, test8dataHistory ?? this.test8dataHistory.values.first)]),
      test9dataHistory: Map.fromEntries([MapEntry(this.test9dataHistory.keys.first, test9dataHistory ?? this.test9dataHistory.values.first)]),
    );
  }

  factory AppHistoryState.fromJson(Map<String, dynamic> json) => _$AppHistoryStateFromJson(json);

  Map<String, dynamic> toJson() => _$AppHistoryStateToJson(this);

  AppDataState get appDataState {
    return AppDataState(
      test1data: test1dataHistory.values.first?.last.data,
      test2data: test2dataHistory.values.first?.last.data,
      test3data: test3dataHistory.values.first?.last.data,
      test4data: test4dataHistory.values.first?.last.data,
      test5data: test5dataHistory.values.first?.last.data,
      test6data: test6dataHistory.values.first?.last.data,
      test7data: test7dataHistory.values.first?.last.data,
      test8data: test8dataHistory.values.first?.last.data,
      test9data: test9dataHistory.values.first?.last.data,
    );
  }

  @override
  List<Object?> get props => [
        profile,
        test1dataHistory,
        test2dataHistory,
        test3dataHistory,
        test4dataHistory,
        test5dataHistory,
        test6dataHistory,
        test7dataHistory,
        test8dataHistory,
        test9dataHistory,
      ];
}
