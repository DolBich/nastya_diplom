import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/app_data/app_data_bloc.dart';
import 'package:nastya_diplom/application/test_9/test_9_bloc.dart';
import 'package:nastya_diplom/domain/reg_ex.dart';
import 'package:nastya_diplom/infrastructure/enum.dart';
import 'package:nastya_diplom/main.dart';
import 'package:nastya_diplom/presentation/routes/router.dart';
import 'package:nastya_diplom/presentation/widgets/timer_indicator.dart';

part 'test_9_form.dart';

@RoutePage()
class Test9Screen extends StatelessWidget {
  const Test9Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppDataBloc>();
    return BlocProvider<Test9Bloc>(
      create: (_) => Test9Bloc(bloc),
      child: const Test9Form(),
    );
  }
}
