part of 'test_7_bloc.dart';

class Test7State with EquatableMixin {
  final List<Test7Image> images;
  final int currentIndex;
  final int errorsCount;
  final int remainingTime;
  final bool isProcessing;
  final bool shouldNavigate;

  const Test7State({
    required this.images,
    required this.currentIndex,
    required this.remainingTime,
    required this.errorsCount,
    required this.isProcessing,
    required this.shouldNavigate,
  });

  factory Test7State.initial() {
    final random = Random();
    List<int> testList = [random.nextInt(2)];
    final initialImages = List.generate(20, (i) {
      int value = random.nextInt(3);
      if (testList.first == value) testList.add(value);
      if (testList.length >= 4) {
        do {
          value = random.nextInt(2);
        } while (value != testList.first);
        testList = [value];
      }

      ImageType type = ImageType.values[value];
      return Test7Image(
        type: type,
        index: i,
      );
    });

    return Test7State(
      images: initialImages,
      currentIndex: 2,
      remainingTime: 2 * 60,
      errorsCount: 0,
      isProcessing: false,
      shouldNavigate: false,
    );
  }

  Test7State copyWith({
    List<Test7Image>? images,
    int? currentIndex,
    int? errorsCount,
    int? remainingTime,
    bool? isProcessing,
    bool? shouldNavigate,
  }) {
    return Test7State(
      images: images ?? this.images,
      currentIndex: currentIndex ?? this.currentIndex,
      remainingTime: remainingTime ?? this.remainingTime,
      errorsCount: errorsCount ?? this.errorsCount,
      isProcessing: isProcessing ?? this.isProcessing,
      shouldNavigate: shouldNavigate ?? this.shouldNavigate,
    );
  }

  @override
  List<Object?> get props => [
        images,
        currentIndex,
        remainingTime,
        errorsCount,
        isProcessing,
        shouldNavigate,
      ];
}

extension Test7StateX on Test7State {
  bool get firstStage => remainingTime >= 2 * 60 - 5;

  double get timeProgress => remainingTime / (2 * 60);

  double get questionsProgress => (currentIndex - 2) / (images.length - 2);

  Test7Image get prePreviousImage => images[currentIndex - 2];

  Test7Image get currentImage => images[currentIndex];

  bool get prePrevIsCur => currentImage == prePreviousImage;

  bool get isCompleted => remainingTime <= 0 || currentIndex > 19;

  SelectionState get returnState {
    return const SelectionState(testType: TestType.test7, showHistory: true);
  }
}
