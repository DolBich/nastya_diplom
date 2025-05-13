part of 'test_2_bloc.dart';

sealed class Test2Event {
  const Test2Event();

  const factory Test2Event.cellTapped(Test2Cell cell) = _CellTapped;

  const factory Test2Event.save() = _Save;

  const factory Test2Event.cancel() = _Cancel;

}

class _Cancel extends Test2Event {
  const _Cancel();
}

class _Save extends Test2Event {
  const _Save();
}

class _CellTapped extends Test2Event {
  final Test2Cell cell;
  const _CellTapped(this.cell);
}
