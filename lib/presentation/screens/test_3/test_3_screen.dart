import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/app_data/app_data_bloc.dart';
import 'package:nastya_diplom/application/test_2/test_2_bloc.dart';
import 'package:nastya_diplom/application/test_3/test_3_bloc.dart';
import 'package:nastya_diplom/domain/test_2/cell.dart';
import 'package:nastya_diplom/domain/test_3/test_3_cell.dart';
import 'package:nastya_diplom/presentation/routes/router.dart';
import 'package:nastya_diplom/presentation/widgets/timer_indicator.dart';

part 'test_3_form.dart';

@RoutePage()
class Test3Screen extends StatelessWidget {
  const Test3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppDataBloc>();
    return BlocProvider<Test3Bloc>(
      create: (_) => Test3Bloc(bloc),
      child: const Test3Form(),
    );
  }
}
