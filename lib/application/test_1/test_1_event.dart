part of 'test_1_bloc.dart';

sealed class Test1Event {
  const Test1Event();

  const factory Test1Event.targetFound(GridNumber target) = _TargetFound;

  const factory Test1Event.error() = _Error;

  const factory Test1Event.save() = _Save;

  const factory Test1Event.cancel() = _Cancel;

}

class _Cancel extends Test1Event {
  const _Cancel();
}

class _Save extends Test1Event {
  const _Save();
}

class _Error extends Test1Event {
  const _Error();
}

class _TargetFound extends Test1Event {
  final GridNumber target;
  const _TargetFound(this.target);
}
