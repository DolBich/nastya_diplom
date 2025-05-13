part of 'selection_bloc.dart';

sealed class SelectionEvent {
  const SelectionEvent();

  const factory SelectionEvent.updateShowHistory() = _UpdateShowHistory;

  const factory SelectionEvent.updateTestType(TestType type) = _UpdateTestType;

  const factory SelectionEvent.reset(SelectionState updatedState) = _Reset;

}

class _Reset extends SelectionEvent {
  final SelectionState updatedState;
  const _Reset(this.updatedState);
}

class _UpdateShowHistory extends SelectionEvent {
  const _UpdateShowHistory();
}

class _UpdateTestType extends SelectionEvent {
  final TestType type;
  const _UpdateTestType(this.type);
}
