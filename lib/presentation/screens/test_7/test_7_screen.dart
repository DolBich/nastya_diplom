import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/app_data/app_data_bloc.dart';
import 'package:nastya_diplom/application/test_7/test_7_bloc.dart';
import 'package:nastya_diplom/domain/test_7/test_7_images.dart';
import 'package:nastya_diplom/infrastructure/enum.dart';
import 'package:nastya_diplom/main.dart';
import 'package:nastya_diplom/presentation/routes/router.dart';

part 'test_7_form.dart';

@RoutePage()
class Test7Screen extends StatelessWidget {
  const Test7Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppDataBloc>();
    return BlocProvider<Test7Bloc>(
      create: (_) => Test7Bloc(bloc),
      child: const Test7Form(),
    );
  }
}
