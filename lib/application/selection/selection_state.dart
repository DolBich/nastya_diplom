part of 'selection_bloc.dart';

class SelectionState with EquatableMixin {
  final TestType testType;
  final bool showHistory;

  const SelectionState({
    required this.testType,
    required this.showHistory,
  });

  factory SelectionState.initial() {
    return SelectionState(
      testType: TestType.values.first,
      showHistory: false,
    );
  }

  SelectionState copyWith({
    TestType? testType,
    bool? showHistory,
  }) {
    return SelectionState(
      testType: testType ?? this.testType,
      showHistory: showHistory ?? this.showHistory,
    );
  }

  @override
  List<Object?> get props => [
        testType,
        showHistory,
      ];
}
