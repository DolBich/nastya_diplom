import 'package:equatable/equatable.dart';

class Test2Cell with EquatableMixin {
  final int? number;
  final bool showCorrect;
  final bool showError;

  Test2Cell copyWith({
    int? number,
    bool? showCorrect,
    bool? showError,
  }) {
    return Test2Cell(
      number: number ?? this.number,
      showCorrect: showCorrect ?? this.showCorrect,
      showError: showError ?? this.showError,
    );
  }

  Test2Cell({
    required this.number,
    this.showCorrect = false,
    this.showError = false,
  });

  @override
  List<Object?> get props => [number, showCorrect, showError];
}
