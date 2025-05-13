import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/app_data/app_data_bloc.dart';
import 'package:nastya_diplom/application/app_history/app_history_bloc.dart';
import 'package:nastya_diplom/infrastructure/saving.dart';
import 'package:nastya_diplom/presentation/routes/router.dart';
import 'package:nastya_diplom/presentation/widgets/error_widget.dart';

void main() async {
  final json = await loadFromFile(DATA_FILE_NAME);
  runApp(MyApp(json: json));
}

const DATA_FILE_NAME = 'data.json';

class MyApp extends StatelessWidget {
  final Map<String, dynamic>? json;

  const MyApp({super.key, this.json});

  static final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppHistoryBloc>(
      create: (_) => AppHistoryBloc(json),
      child: Builder(builder: (context) {
        final historyBloc = context.read<AppHistoryBloc>();
        return BlocProvider<AppDataBloc>(
          create: (_) => AppDataBloc(historyBloc),
          child: MaterialApp.router(
            routerDelegate: AutoRouterDelegate(_appRouter),
            routeInformationParser: _appRouter.defaultRouteParser(),
            builder: (context, child) {
              if (child == null) return const LoadingErrorWidget();
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                child: child,
              );
            },
          ),
        );
      }),
    );
  }
}
