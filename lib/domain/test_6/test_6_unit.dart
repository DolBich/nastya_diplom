import 'dart:ui';

import 'package:equatable/equatable.dart';

class ConnectionLine with EquatableMixin {
  final int leftIndex; // Индекс квадрата слева (1-25)
  final int? answer;
  final int rightIndex; // Индекс квадрата справа (1-25)
  final Path path; // Путь для отрисовки линии
  final List<Offset> controlPoints; // Контрольные точки для изгибов

  ConnectionLine({
    required this.leftIndex,
    required this.rightIndex,
    required this.answer,
    required this.path,
    required this.controlPoints,
  });

  ConnectionLine copyWith({
    int? answer,
  }) {
    return ConnectionLine(
      leftIndex: leftIndex,
      rightIndex: rightIndex,
      answer: answer ?? this.answer,
      path: path,
      controlPoints: controlPoints,
    );
  }

  bool get isError => leftIndex != answer;

  @override
  List<Object?> get props => [
        leftIndex,
        answer,
        path,
        controlPoints,
      ];
}
