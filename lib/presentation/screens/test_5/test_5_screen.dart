import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/app_data/app_data_bloc.dart';
import 'package:nastya_diplom/application/test_5/test_5_bloc.dart';
import 'package:nastya_diplom/domain/test_5/test_5_cell.dart';
import 'package:nastya_diplom/infrastructure/enum.dart';
import 'package:nastya_diplom/presentation/routes/router.dart';
import 'package:nastya_diplom/presentation/widgets/timer_indicator.dart';

part 'test_5_form.dart';

@RoutePage()
class Test5Screen extends StatelessWidget {
  const Test5Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppDataBloc>();
    return BlocProvider<Test5Bloc>(
      create: (_) => Test5Bloc(bloc),
      child: const Test5Form(),
    );
  }
}
