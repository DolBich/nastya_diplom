part of 'custom_bloc.dart';

class CustomState extends Equatable {
  final bool isRefreshing;
  final bool isPreview;
  final int initialCount;
  final int count;

  const CustomState({
    required this.isRefreshing,
    required this.isPreview,
    required this.count,
    required this.initialCount,
  });

  factory CustomState.initial() {
    return const CustomState(
      initialCount: 0,
      isRefreshing: false,
      isPreview: true,
      count: 0,
    );
  }

  CustomState copyWith({
    bool? isRefreshing,
    bool? isPreview,
    int? count,
    int? initialCount,
  }) {
    return CustomState(
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isPreview: isPreview ?? this.isPreview,
      count: count ?? this.count,
      initialCount: initialCount ?? this.initialCount,
    );
  }

  @override
  List<Object?> get props => [
        isPreview,
        isRefreshing,
        count,
        initialCount,
      ];
}

extension CustomStateX on CustomState {
  bool get hasChanges => initialCount != count;
}
