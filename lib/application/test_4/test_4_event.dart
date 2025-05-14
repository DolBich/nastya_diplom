part of 'test_4_bloc.dart';

sealed class Test4Event {
  const Test4Event();

  const factory Test4Event.symbolSelected(IconData symbol) = _SymbolSelected;

  const factory Test4Event.save() = _Save;

  const factory Test4Event.cancel() = _Cancel;

}

class _Cancel extends Test4Event {
  const _Cancel();
}

class _Save extends Test4Event {
  const _Save();
}

class _SymbolSelected extends Test4Event {
  final IconData symbol;
  const _SymbolSelected(this.symbol);
}
