import 'package:equatable/equatable.dart';

enum SoundType { sound1, sound2, sound3, sound4, sound5, sound6 }

enum BackgroundSoundType { sound1, sound2, sound3, sound4, sound5 }

extension SoundTypeExtension on SoundType {
  String get assetPath {
    const basePath = 'sounds/events';
    return switch (this) {
      SoundType.sound1 => '$basePath/sound1.mp3',
      SoundType.sound2 => '$basePath/sound2.wav',
      SoundType.sound3 => '$basePath/sound3.wav',
      SoundType.sound4 => '$basePath/sound4.wav',
      SoundType.sound5 => '$basePath/sound5.mp3',
      SoundType.sound6 => '$basePath/sound6.wav',
    };
  }

  Duration get duration => const Duration(milliseconds: 1000);
}

extension BackgroundSoundTypeExtension on BackgroundSoundType {
  String get assetPath {
    const basePath = 'sounds/background';
    return switch (this) {
      BackgroundSoundType.sound1 => '$basePath/sound1.mp3',
      BackgroundSoundType.sound2 => '$basePath/sound2.mp3',
      BackgroundSoundType.sound3 => '$basePath/sound3.mp3',
      BackgroundSoundType.sound4 => '$basePath/sound4.mp3',
      BackgroundSoundType.sound5 => '$basePath/sound5.mp3',
    };
  }

  Duration get duration => const Duration(minutes: 2);
}

class SoundEvent with EquatableMixin {
  final SoundType type;
  final int timestamp; // В секундах от начала теста
  final int duration; // В миллисекундах
  final bool wrong;

  const SoundEvent({
    required this.type,
    required this.timestamp,
    this.duration = 1000,
    this.wrong = true,
  });

  SoundEvent copyWith({
    SoundType? type,
    int? timestamp,
    bool? wrong,
  }) {
    return SoundEvent(
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      duration: duration,
      wrong: wrong ?? this.wrong,
    );
  }

  bool isActiveAt(int time) => time >= timestamp && time <= timestamp + duration ~/ 1000;

  @override
  List<Object?> get props => [type, timestamp, duration, wrong];
}
