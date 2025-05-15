part of 'test_7_bloc.dart';

sealed class Test7Event {
  const Test7Event();

  const factory Test7Event.isEqual(bool equal) = _IsEqual;

  const factory Test7Event.updateRemainingTime() = _UpdateRemainingTime;

  const factory Test7Event.save() = _Save;

  const factory Test7Event.cancel() = _Cancel;

}

class _IsEqual extends Test7Event {
  final bool isEqual;
  const _IsEqual(this.isEqual);
}

class _UpdateRemainingTime extends Test7Event {
  const _UpdateRemainingTime();
}

class _Cancel extends Test7Event {
  const _Cancel();
}

class _Save extends Test7Event {
  const _Save();
}

