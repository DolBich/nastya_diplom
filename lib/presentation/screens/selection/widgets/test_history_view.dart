import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nastya_diplom/application/app_history/app_history_bloc.dart';
import 'package:nastya_diplom/domain/data/test_data.dart';
import 'package:nastya_diplom/domain/history/history_unit.dart';
import 'package:nastya_diplom/infrastructure/enum.dart';
import 'package:nastya_diplom/presentation/widgets/result_widget.dart';

class TestHistoryView extends StatelessWidget {
  final TestType test;

  const TestHistoryView({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppHistoryBloc, AppHistoryState>(
      // buildWhen: (p, c) {
      //   final prevProps = p.props;
      //   List<HistoryUnit> prev = [];
      //   for (final prop in prevProps) {
      //     if (prop is MapEntry) {
      //       if (prop.key == TestType) {
      //         prev = prop.value;
      //       }
      //     }
      //   }
      //   final curProps = c.props;
      //   List<HistoryUnit> cur = [];
      //   for (final prop in curProps) {
      //     if (prop is MapEntry) {
      //       if (prop.key == TestType) {
      //         cur = prop.value;
      //       }
      //     }
      //   }
      //
      //   return prev.length != cur.length;
      // },
      builder: (context, state) {
        List<HistoryUnit> history = [];
        for (final prop in state.props) {
          if (prop is Map) {
            if (prop.keys.first == test) {
              history = prop.values.first;
            }
          }
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: history.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final i = history.length - index - 1;
            final HistoryUnit attempt = history[i];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _AttemptHeader(attempt: attempt, index: i),
                    const SizedBox(height: 12),
                    _ResultPreview(data: attempt.data),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _AttemptHeader extends StatelessWidget {
  final HistoryUnit attempt;
  final int index;

  const _AttemptHeader({
    required this.attempt,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Попытка №${index + 1}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const Spacer(),
        Text(
          DateFormat('dd.MM.yyyy HH:mm').format(attempt.date),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _ResultPreview extends StatelessWidget {
  final TestData data;

  const _ResultPreview({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: ResultWidget(data: data),
    );
  }
}
