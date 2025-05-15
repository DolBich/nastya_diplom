import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum ImageType { first, second, third }

extension ImageTypeIcon on ImageType {
  IconData get getIcon {
    return switch (this) {
      ImageType.first => Icons.ac_unit_outlined,
      ImageType.second => Icons.accessibility_new_outlined,
      ImageType.third => Icons.beach_access_outlined,
    };
  }
}

class Test7Image with EquatableMixin {
  final ImageType type;
  final int index;
  final bool showError;
  final bool showCorrect;

  const Test7Image({
    required this.type,
    required this.index,
    this.showError = false,
    this.showCorrect = false,
  });

  Test7Image copyWith({
    bool? showError,
    bool? showCorrect,
  }) {
    return Test7Image(
      type: type,
      index: index,
      showCorrect: showCorrect ?? this.showCorrect,
      showError: showError ?? this.showError,
    );
  }

  @override
  List<Object?> get props => [type, showError, showCorrect];

}
