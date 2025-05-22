part of 'test_6_bloc.dart';

class Test6State with EquatableMixin {
  final List<ConnectionLine> lines;
  final int remainingTime;
  final bool isCompleted;
  final bool isCursorVisible;
  final bool shouldNavigate;

  const Test6State({
    required this.lines,
    required this.remainingTime,
    required this.isCompleted,
    required this.isCursorVisible,
    required this.shouldNavigate,
  });

  factory Test6State.initial() {
    return Test6State(
      lines: _generateLines(),
      remainingTime: 7 * 60,
      isCompleted: false,
      isCursorVisible: true,
      shouldNavigate: false,
    );
  }

  static List<ConnectionLine> _generateLines() {
    final random = Random();
    final rightIndices = List.generate(25, (i) => i)..shuffle(random);

    return List.generate(25, (leftIndex) {
      final rightIndex = rightIndices[leftIndex];
      return _createLine(
            leftIndex: leftIndex,
            rightIndex: rightIndex,
            random: random,
          ) ??
          ConnectionLine(
            leftIndex: leftIndex,
            rightIndex: rightIndex,
            answer: null,
            path: Path(),
            controlPoints: [],
          );
    });
  }

  static ConnectionLine? _createLine({
    required int leftIndex,
    required int rightIndex,
    required Random random,
  }) {
    const middleWidth = 500.0;
    const rowHeight = 25.0;
    const maxHeight = 25 * rowHeight;
    const edgePadding = 20.0; // Отступ от границ

    final start = Offset(0, leftIndex * rowHeight + rowHeight / 2);
    final end = Offset(middleWidth, rightIndex * rowHeight + rowHeight / 2);

    final segments = 3 + random.nextInt(2);
    final path = Path();
    path.moveTo(start.dx, start.dy);

    final segmentFractions = List.generate(segments, (_) => random.nextDouble());
    final totalFraction = segmentFractions.reduce((a, b) => a + b);
    var segmentWidths = segmentFractions.map((f) => f * middleWidth / totalFraction).toList();

    // Корректировка последнего сегмента
    segmentWidths[segmentWidths.length - 1] = segmentFractions.last * middleWidth / totalFraction - edgePadding;

    double currentX = 0;
    final controlPoints = <Offset>[];
    double prevY = start.dy;

    for (var i = 0; i < segments; i++) {
      final segmentWidth = segmentWidths[i];
      final isLastSegment = i == segments - 1;
      final isFirstSegment = i == 0;

      // Ограничение вертикального отклонения
      const maxVerticalDeviation = 350;
      double deviation = (random.nextDouble() * 2 - 1) * maxVerticalDeviation;

      // Плавное изменение направления
      if (i > 0) {
        final prevDeviation = controlPoints.last.dy - prevY;
        deviation = prevDeviation * 0.3 + deviation * 0.7;
      }

      // Расчет базовой позиции
      final targetY = start.dy + (end.dy - start.dy) * (currentX + segmentWidth) / middleWidth;
      final baseY = prevY + (targetY - prevY) * 0.6;

      // Горизонтальное отклонение (может быть отрицательным)
      double horizontalDeviation = random.nextDouble() * 150 - 250;
      if (isFirstSegment || isLastSegment) {
        horizontalDeviation = 0;
        deviation = 0;
      }

      // Тип кривой
      final curveType = random.nextInt(5);
      var (ctrl1, ctrl2) = switch (curveType) {
        0 => _createSmoothCurve(currentX, baseY, segmentWidth, horizontalDeviation, deviation),
        1 => _createReverseCurve(currentX, baseY, segmentWidth, horizontalDeviation, deviation),
        2 => _createSpiralCurve(currentX, baseY, segmentWidth, horizontalDeviation, deviation),
        3 => _createStepCurve(currentX, baseY, segmentWidth, horizontalDeviation, deviation),
        _ => _createRandomCurve(currentX, baseY, segmentWidth, horizontalDeviation, deviation),
      };

      // Корректировка последних контрольных точек
      if (isLastSegment) {
        ctrl2 = Offset(
          (currentX + segmentWidth).clamp(currentX + segmentWidth - edgePadding, middleWidth - edgePadding),
          ctrl2.dy.clamp(rowHeight / 2.1, maxHeight - rowHeight / 2.1),
        );
      }

      if (isFirstSegment) {
        ctrl2 = Offset(
          (currentX + segmentWidth).clamp(edgePadding, currentX + segmentWidth + edgePadding),
          ctrl2.dy,
        );
      }

      if (isFirstSegment) {
        path.cubicTo(
          ctrl1.dx,
          ctrl1.dy.clamp(rowHeight / 2.1, maxHeight - rowHeight / 2.1),
          ctrl2.dx.clamp(edgePadding, middleWidth),
          ctrl2.dy.clamp(rowHeight / 2.1, maxHeight - rowHeight / 2.1),
          (currentX + segmentWidth + edgePadding).clamp(edgePadding, middleWidth),
          baseY.clamp(rowHeight / 2.1, maxHeight - rowHeight / 2.1),
        );
      } else if (isLastSegment) {
        path.cubicTo(
          ctrl1.dx,
          ctrl1.dy.clamp(rowHeight / 2.1, maxHeight - rowHeight / 2.1),
          ctrl2.dx.clamp(0, currentX - edgePadding + segmentWidth),
          ctrl2.dy.clamp(rowHeight / 2.1, maxHeight - rowHeight / 2.1),
          (currentX + segmentWidth - edgePadding).clamp(0, middleWidth - edgePadding),
          baseY.clamp(rowHeight / 2.1, maxHeight - rowHeight / 2.1),
        );
      } else {
        path.cubicTo(
          ctrl1.dx,
          ctrl1.dy.clamp(rowHeight / 2.1, maxHeight - rowHeight / 2.1),
          ctrl2.dx.clamp(currentX, currentX + segmentWidth),
          ctrl2.dy.clamp(rowHeight / 2.1, maxHeight - rowHeight / 2.1),
          currentX + segmentWidth,
          baseY.clamp(rowHeight / 2.1, maxHeight - rowHeight / 2.1),
        );
      }

      controlPoints.addAll([ctrl1, ctrl2]);
      prevY = baseY;
      currentX += segmentWidth;
    }

    path.lineTo(end.dx, end.dy);

    return ConnectionLine(
      leftIndex: leftIndex + 1,
      rightIndex: rightIndex + 1,
      path: path,
      answer: null,
      controlPoints: controlPoints,
    );
  }

// Новые типы кривых
  static (Offset, Offset) _createSmoothCurve(double x, double y, double width, double hDev, double vDev) {
    return (
      Offset(x + width * 0.2 + hDev, y - vDev * 0.5),
      Offset(x + width * 0.8 - hDev, y + vDev * 0.5),
    );
  }

  static (Offset, Offset) _createReverseCurve(double x, double y, double width, double hDev, double vDev) {
    return (
      Offset(x + width * 0.3 + hDev, y - vDev),
      Offset(x + width * 0.7 - hDev, y + vDev),
    );
  }

  static (Offset, Offset) _createSpiralCurve(double x, double y, double width, double hDev, double vDev) {
    return (
      Offset(x + width * 0.4 + hDev, y - vDev * 1.2),
      Offset(x + width * 0.6 - hDev, y + vDev * 0.8),
    );
  }

  static (Offset, Offset) _createStepCurve(double x, double y, double width, double hDev, double vDev) {
    return (
      Offset(x + width * 0.5 + hDev, y - vDev),
      Offset(x + width * 0.5 - hDev, y + vDev),
    );
  }

  static (Offset, Offset) _createRandomCurve(double x, double y, double width, double hDev, double vDev) {
    final random = Random();

    return (
      Offset(
        x + width * (0.2 + 0.6 * random.nextDouble()) + hDev,
        y + vDev * (random.nextDouble() - 0.5) * 2,
      ),
      Offset(
        x + width * (0.5 + 0.3 * random.nextDouble()) - hDev,
        y + vDev * (random.nextDouble() - 0.5) * 2,
      ),
    );
  }

  Test6State copyWith({
    List<ConnectionLine>? lines,
    int? remainingTime,
    bool? isCompleted,
    bool? isCursorVisible,
    bool? shouldNavigate,
  }) {
    return Test6State(
      lines: lines ?? this.lines,
      remainingTime: remainingTime ?? this.remainingTime,
      isCompleted: isCompleted ?? this.isCompleted,
      isCursorVisible: isCursorVisible ?? this.isCursorVisible,
      shouldNavigate: shouldNavigate ?? this.shouldNavigate,
    );
  }

  @override
  List<Object?> get props => [
        lines,
        remainingTime,
        isCursorVisible,
        isCompleted,
        shouldNavigate,
      ];
}

extension Test6StateX on Test6State {
  int get errors => lines.where((line) => line.isError).length;

  SelectionState get returnState {
    return const SelectionState(testType: TestType.test6, showHistory: true);
  }
}
