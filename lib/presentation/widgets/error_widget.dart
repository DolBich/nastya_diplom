import 'package:flutter/material.dart';

class LoadingErrorWidget extends StatelessWidget {
  final String title;
  final String msg;

  const LoadingErrorWidget({
    super.key,
    this.title = '',
    this.msg = '',
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: SizedBox(
        width: 450,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Произошла ошибка',
              style: theme.textTheme.displayLarge,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title.isNotEmpty ? title : 'Во время зашрузки страницы возникла ошибка. Обратитесь к лечащему врачу\n'
                    'за инструкциями если ошибка повториться снова',
                style: theme.textTheme.headlineSmall,
              ),
            ),
            if (msg.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(msg, style: theme.textTheme.bodyMedium),
              ),
          ],
        ),
      ),
    );
  }
}