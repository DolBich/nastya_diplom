import 'package:flutter/material.dart';
import 'package:nastya_diplom/application/timer.dart';
import 'package:nastya_diplom/main.dart';

class TimerIndicator extends StatefulWidget {
  final TimerService timer;
  const TimerIndicator({super.key, required this.timer});

  @override
  State<TimerIndicator> createState() => _TimerIndicatorState();
}

class _TimerIndicatorState extends State<TimerIndicator> {
  bool visible = true;

  get _changeVisible => setState(() => visible = !visible);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if(visible) _TimerText(widget.timer),
        const SizedBox(width: 8),
        IconButton(
          icon: Icon(visible ? Icons.visibility : Icons.visibility_off),
          onPressed: () => _changeVisible,
        ),
      ],
    );
  }
}

class _TimerText extends StatefulWidget {
  final TimerService timer;
  const _TimerText(this.timer);

  @override
  State<_TimerText> createState() => _TimerTextState();
}

class _TimerTextState extends State<_TimerText> {

  Duration duration = const Duration();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => widget.timer.start());
    widget.timer.timerStream.listen((dur){
      if(duration != dur && ((duration.inSeconds - dur.inSeconds).abs() >= 1)) {
        setState(() {
          duration = dur;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatDuration(duration),
      style: const TextStyle(fontSize: DEFAULT_TEXT_SIZE),
    );
  }

  String _formatDuration(Duration d) =>
      '${d.inMinutes.toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';
}

