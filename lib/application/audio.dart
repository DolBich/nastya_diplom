import 'package:audioplayers/audioplayers.dart';
import 'package:nastya_diplom/domain/test_8/sounds.dart';

class AudioPlayerService {
  final AudioPlayer _backgroundPlayer = AudioPlayer()..setVolume(0.1);
  final AudioPlayer _effectsPlayer = AudioPlayer()..setVolume(0.2);

  Stream<PlayerState> playSound(SoundType type) {
    print('play $type');
      _effectsPlayer.play(AssetSource(type.assetPath));
      return _effectsPlayer.onPlayerStateChanged;
  }

  Stream<PlayerState> playBackground(BackgroundSoundType type) {
    _backgroundPlayer.play(AssetSource(type.assetPath));
    return _backgroundPlayer.onPlayerStateChanged;
  }

  bool get isEventPlaying {
    return _effectsPlayer.state == PlayerState.playing;
  }

  Future<void> stop() async {
    await _backgroundPlayer.stop();
    await _effectsPlayer.stop();
  }

  Future<void> dispose() async {
    await _backgroundPlayer.dispose();
    await _effectsPlayer.dispose();
  }
}
