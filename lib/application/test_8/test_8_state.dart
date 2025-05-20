part of 'test_8_bloc.dart';

class Test8State with EquatableMixin {
  final SoundType selectedSound;
  final BackgroundSoundType? currentBackground;
  final int remainingTime;
  final bool showFeedback;
  final List<SoundEvent> soundEvents;
  final int errorsCount;
  final bool isPlaying;
  final SoundEvent? activeSoundEvent;

  const Test8State({
    required this.selectedSound,
    required this.currentBackground,
    required this.remainingTime,
    required this.showFeedback,
    required this.soundEvents,
    required this.errorsCount,
    required this.isPlaying,
    required this.activeSoundEvent,
  });

  static List<SoundEvent> _generateSoundEvents(SoundType targetSound) {
    final random = Random();
    final events = <SoundEvent>[];
    final totalEvents = 10 + random.nextInt(11);
    const padding = 2;
    final gap = 120~/totalEvents;
    int currentTime = 0;

    // Генерируем остальные события
    for (int i = 0; i < totalEvents; i++) {
      final soundType = SoundType.values.randomElement();

      currentTime = i*gap + padding + random.nextInt(gap - padding);
      if (currentTime >= 120) break;

      events.add(SoundEvent(
        type: soundType,
        timestamp: currentTime,
        duration: 1000,
      ));
    }

    if (!events.any((e) => e.type == targetSound)) {
      final index = random.nextInt(events.length);
      events[index] = events[index].copyWith(type: targetSound);
    }

    events.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return events;
  }

  factory Test8State.initial() {
    final targetSound = SoundType.values.randomElement();
    final soundEvents = _generateSoundEvents(targetSound);

    return Test8State(
      selectedSound: targetSound,
      remainingTime: 120,
      showFeedback: false,
      soundEvents: soundEvents,
      errorsCount: 0,
      isPlaying: false,
      currentBackground: BackgroundSoundType.values.randomElement(),
      activeSoundEvent: soundEvents.first,
    );
  }

  Test8State copyWith({
    SoundType? selectedSound,
    int? remainingTime,
    bool? isCompleted,
    bool? showFeedback,
    List<SoundEvent>? soundEvents,
    int? currentSoundIndex,
    int? errorsCount,
    bool? isPlaying,
    BackgroundSoundType? currentBackground,
    SoundEvent? activeSoundEvent,
  }) {
    return Test8State(
      selectedSound: selectedSound ?? this.selectedSound,
      remainingTime: remainingTime ?? this.remainingTime,
      showFeedback: showFeedback ?? this.showFeedback,
      soundEvents: soundEvents ?? this.soundEvents,
      errorsCount: errorsCount ?? this.errorsCount,
      isPlaying: isPlaying ?? this.isPlaying,
      currentBackground: currentBackground ?? this.currentBackground,
      activeSoundEvent: activeSoundEvent,
    );
  }

  @override
  List<Object?> get props => [
        selectedSound,
        remainingTime,
        isCompleted,
        showFeedback,
        currentBackground,
        soundEvents,
        activeSoundEvent,
        errorsCount,
        isPlaying,
      ];
}

extension Test8StateX on Test8State {
  double get timeProgress => remainingTime / (2 * 60);

  bool get isCompleted => remainingTime <= 0;

  SelectionState get returnState {
    return const SelectionState(testType: TestType.test8, showHistory: true);
  }
}
