import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum ShapeType { star, circle, triangle, heart, square }

class ShapeSymbol with EquatableMixin {
  final ShapeType type;
  final IconData symbol;

  const ShapeSymbol({
    required this.type,
    required this.symbol,
  });

  ShapeSymbol copyWith({
    ShapeType? type,
    IconData? symbol,
  }) {
    return ShapeSymbol(
      type: type ?? this.type,
      symbol: symbol ?? this.symbol,
    );
  }

  @override
  List<Object?> get props => [type, symbol];
}
