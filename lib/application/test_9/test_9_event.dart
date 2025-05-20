part of 'test_9_bloc.dart';

sealed class Test9Event {
  const Test9Event();

  const factory Test9Event.updatePosition() = _UpdatePosition;

  const factory Test9Event.answerSubmitted(int answer) = _AnswerSubmitted;

  const factory Test9Event.pauseAnimation() = _PauseAnimation;

  const factory Test9Event.resumeAnimation() = _ResumeAnimation;

  const factory Test9Event.save() = _Save;

  const factory Test9Event.cancel() = _Cancel;

}

class _UpdatePosition extends Test9Event {
  const _UpdatePosition();
}

class _AnswerSubmitted extends Test9Event {
  final int answer;
  const _AnswerSubmitted(this.answer);
}

class _PauseAnimation extends Test9Event {
  const _PauseAnimation();
}

class _ResumeAnimation extends Test9Event {
  const _ResumeAnimation();
}

class _Save extends Test9Event {
  const _Save();
}

class _Cancel extends Test9Event {
  const _Cancel();
}

