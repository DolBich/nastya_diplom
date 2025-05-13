import 'dart:async';
import 'package:async/async.dart';

class TimerService {
  final Stopwatch _stopwatch = Stopwatch();
  final StreamController<Duration> _controller = StreamController.broadcast();
  CancelableOperation? _timerOperation;

  Stream<Duration> get timerStream => _controller.stream;

  bool get isRunning => _stopwatch.isRunning;

  void start() {
    if (_stopwatch.isRunning) return;

    _stopwatch.start();
    _timerOperation = CancelableOperation.fromFuture(
      _updateTimer(),
      onCancel: () => _controller.close(),
    );
  }

  Duration get duration {
    return _stopwatch.elapsed;
  }

  Future<void> _updateTimer() async {
    while (_stopwatch.isRunning) {
      await Future.delayed(const Duration(milliseconds: 100));
      _controller.add(_stopwatch.elapsed);
    }
  }

  void pause() {
    _stopwatch.stop();
    _timerOperation?.cancel();
  }

  void reset() {
    _stopwatch.reset();
    _controller.add(Duration.zero);
  }

  Duration stop() {
    pause();
    final elapsed = _stopwatch.elapsed;
    reset();
    return elapsed;
  }

  void dispose() {
    _controller.close();
    _timerOperation?.cancel();
  }
}