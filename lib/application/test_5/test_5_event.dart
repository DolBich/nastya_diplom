part of 'test_5_bloc.dart';

sealed class Test5Event {
  const Test5Event();

  const factory Test5Event.dotSelected(int dotIndex) = _DotSelected;

  const factory Test5Event.nextPhase() = _NextPhase;

  const factory Test5Event.save() = _Save;

  const factory Test5Event.cancel() = _Cancel;

}

class _Cancel extends Test5Event {
  const _Cancel();
}

class _Save extends Test5Event {
  const _Save();
}

class _NextPhase extends Test5Event {
  const _NextPhase();
}

class _DotSelected extends Test5Event {
  final int dotIndex;
  const _DotSelected(this.dotIndex);
}
