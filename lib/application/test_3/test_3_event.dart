part of 'test_3_bloc.dart';

sealed class Test3Event {
  const Test3Event();

  const factory Test3Event.cellTapped(Test3Cell cell) = _CellTapped;

  const factory Test3Event.save() = _Save;

  const factory Test3Event.cancel() = _Cancel;

}

class _Cancel extends Test3Event {
  const _Cancel();
}

class _Save extends Test3Event {
  const _Save();
}

class _CellTapped extends Test3Event {
  final Test3Cell cell;
  const _CellTapped(this.cell);
}
