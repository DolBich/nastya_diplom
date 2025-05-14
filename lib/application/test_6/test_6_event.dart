part of 'test_6_bloc.dart';

sealed class Test6Event {
  const Test6Event();

  const factory Test6Event.updateAnswer({required int rightIndex, required int answer}) = _UpdateAnswer;

  const factory Test6Event.toggleCursor() = _ToggleCursor;

  const factory Test6Event.updateRemainingTime() = _UpdateRemainingTime;

  const factory Test6Event.complete() = _Complete;

  const factory Test6Event.save() = _Save;

  const factory Test6Event.cancel() = _Cancel;

}

class _UpdateAnswer extends Test6Event {
  final int rightIndex;
  final int answer;

  const _UpdateAnswer({required this.rightIndex, required this.answer});
}

class _ToggleCursor extends Test6Event {
  const _ToggleCursor();
}

class _UpdateRemainingTime extends Test6Event {
  const _UpdateRemainingTime();
}

class _Cancel extends Test6Event {
  const _Cancel();
}

class _Complete extends Test6Event {
  const _Complete();
}

class _Save extends Test6Event {
  const _Save();
}

