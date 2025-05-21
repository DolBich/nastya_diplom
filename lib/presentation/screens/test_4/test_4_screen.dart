import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/app_data/app_data_bloc.dart';
import 'package:nastya_diplom/application/test_4/test_4_bloc.dart';
import 'package:nastya_diplom/domain/test_4/test_4_models.dart';
import 'package:nastya_diplom/infrastructure/enum.dart';
import 'package:nastya_diplom/presentation/routes/router.dart';
import 'package:nastya_diplom/presentation/widgets/timer_indicator.dart';

part 'test_4_form.dart';

@RoutePage()
class Test4Screen extends StatelessWidget {
  const Test4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppDataBloc>();
    return BlocProvider<Test4Bloc>(
      create: (_) => Test4Bloc(bloc),
      child: const Test4Form(),
    );
  }
}
