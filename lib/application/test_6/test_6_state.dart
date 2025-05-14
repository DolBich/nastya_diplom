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
    final rightIndices = List.generate(25, (i) => i)
      ..shuffle(random);

    return List.generate(25, (leftIndex) {
      final rightIndex = rightIndices[leftIndex];
      return _createLine(
        leftIndex: leftIndex,
        rightIndex: rightIndex,
        random: random,
      );
    });
  }

  static ConnectionLine _createLine({
    required int leftIndex,
    required int rightIndex,
    required Random random,
  }) {
    const columnWidth = 60.0;
    const middleWidth = 500.0;
    const rowHeight = 40.0;

    // Стартовая точка (центр левого квадрата)
    final start = Offset(
      columnWidth,
      leftIndex * rowHeight + rowHeight / 2,
    );

    // Конечная точка (центр правого квадрата)
    final end = Offset(
      columnWidth + middleWidth,
      rightIndex * rowHeight + rowHeight / 2,
    );

    final path = Path();
    path.moveTo(start.dx, start.dy);

    // Генерация изгибов
    final controlPoints = <Offset>[];
    final segments = 3;
    final segmentWidth = middleWidth / (segments + 1);

    for (var i = 1; i <= segments; i++) {
      final baseX = columnWidth + segmentWidth * i;
      final deviationY = (random.nextDouble() * 100 - 50);

      final ctrlPoint = Offset(
        baseX,
        start.dy + (end.dy - start.dy) * (i / (segments + 1)) + deviationY,
      );

      path.quadraticBezierTo(
        ctrlPoint.dx,
        ctrlPoint.dy,
        baseX,
        ctrlPoint.dy,
      );

      controlPoints.add(ctrlPoint);
    }

    path.lineTo(end.dx, end.dy);

    return ConnectionLine(
      leftIndex: leftIndex + 1,
      rightIndex: rightIndex + 1,
      path: path,
      controlPoints: controlPoints,
      answer: null,
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
