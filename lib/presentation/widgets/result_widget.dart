import 'package:flutter/material.dart';
import 'package:nastya_diplom/domain/data/test_data.dart';
import 'package:nastya_diplom/domain/duration_ext.dart';
import 'package:nastya_diplom/main.dart';

class ResultWidget extends StatelessWidget {
  final TestData data;
  const ResultWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Число ошибок: ${data.errorsCount}',  style: const TextStyle(fontSize: DEFAULT_TEXT_SIZE),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Время: ${data.duration.clockFormat}', style: const TextStyle(fontSize: DEFAULT_TEXT_SIZE),),
        ),
      ],
    );
  }
}
