import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/app_data/app_data_bloc.dart';
import 'package:nastya_diplom/application/test_8/test_8_bloc.dart';
import 'package:nastya_diplom/presentation/routes/router.dart';

part 'test_8_form.dart';

@RoutePage()
class Test8Screen extends StatelessWidget {
  const Test8Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppDataBloc>();
    return BlocProvider<Test8Bloc>(
      create: (_) => Test8Bloc(bloc),
      child: const Test8Form(),
    );
  }
}
