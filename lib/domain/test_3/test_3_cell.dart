import 'package:equatable/equatable.dart';

class Test3Cell with EquatableMixin {
  final int number;
  final bool isBlack;
  final bool showError;
  final bool showCorrect;

  Test3Cell({
    required this.number,
    required this.isBlack,
    this.showError = false,
    this.showCorrect = false,
  });

  Test3Cell copyWith({
    bool? showError,
    bool? showCorrect,
  }) {
    return Test3Cell(
      number: number,
      isBlack: isBlack,
      showError: showError ?? this.showError,
      showCorrect: showCorrect ?? this.showCorrect,
    );
  }

  @override
  List<Object?> get props => [number, isBlack, showError, showCorrect];
}