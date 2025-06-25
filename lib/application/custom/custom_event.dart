part of 'custom_bloc.dart';

sealed class CustomEvent {
  const CustomEvent();

  const factory CustomEvent.refresh() = _Refresh;

  const factory CustomEvent.changePreview() = _ChangePreview;

  const factory CustomEvent.buttonPushed() = _ButtonPushed;

  const factory CustomEvent.save() = _Save;
}

class _ChangePreview extends CustomEvent {
  const _ChangePreview();
}

class _ButtonPushed extends CustomEvent {
  const _ButtonPushed();
}

class _Save extends CustomEvent {
  const _Save();
}

class _Refresh extends CustomEvent {
  const _Refresh();
}