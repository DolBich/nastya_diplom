import 'package:flutter/material.dart';
import 'package:nastya_diplom/infrastructure/enum.dart';
import 'package:nastya_diplom/presentation/routes/router.dart';

class InstructionView extends StatelessWidget {
  const InstructionView({super.key, required this.testType});

  final TestType testType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Text(
              testType.instructionText,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.5,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.justify,
              softWrap: true,
              maxLines: null,
            ),
          ),
        ),


        Padding(
          padding: const EdgeInsets.only(
            bottom: 32.0,
            top: 16.0,
            left: 24.0,
            right: 24.0,
          ),
          child: FilledButton(
            onPressed: () => context.router.navigate(testType.testRoute),
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Начать тест',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}