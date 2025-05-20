part of 'test_8_bloc.dart';

sealed class Test8Event {
  const Test8Event();

  const factory Test8Event.save() = _Save;

  const factory Test8Event.handleSoundEvent(SoundEvent sound) = _HandleSoundEvent;

  const factory Test8Event.playNextBackground() = _PlayNextBackground;

  const factory Test8Event.buttonPressed() = _ButtonPressed;

  const factory Test8Event.init() = _Init;

  const factory Test8Event.updateRemainingTime() = _UpdateRemainingTime;

  const factory Test8Event.cancel() = _Cancel;

}

class _Save extends Test8Event {
  const _Save();
}

class _HandleSoundEvent extends Test8Event {
  final SoundEvent sound;
  const _HandleSoundEvent(this.sound);
}

class _PlayNextBackground extends Test8Event {
  const _PlayNextBackground();
}

class _ButtonPressed extends Test8Event {
  const _ButtonPressed();
}

class _Init extends Test8Event {
  const _Init();
}

class _UpdateRemainingTime extends Test8Event {
  const _UpdateRemainingTime();
}

class _Cancel extends Test8Event {
  const _Cancel();
}

