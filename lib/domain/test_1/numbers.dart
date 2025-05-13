import 'package:equatable/equatable.dart';

class GridNumber with EquatableMixin {
  final int value;
  final bool isFound;
  final bool isTarget;

  GridNumber({
    required this.value,
    this.isFound = false,
    required this.isTarget,
  });

  @override
  List<Object?> get props => [value, isFound, isTarget];
}