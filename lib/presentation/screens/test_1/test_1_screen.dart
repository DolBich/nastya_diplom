import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/app_data/app_data_bloc.dart';
import 'package:nastya_diplom/application/test_1/test_1_bloc.dart';
import 'package:nastya_diplom/domain/test_1/numbers.dart';
import 'package:nastya_diplom/infrastructure/enum.dart';
import 'package:nastya_diplom/presentation/routes/router.dart';
import 'package:nastya_diplom/presentation/widgets/timer_indicator.dart';

part 'test_1_form.dart';

@RoutePage()
class Test1Screen extends StatelessWidget {
  const Test1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppDataBloc>();
    return BlocProvider<Test1Bloc>(
      create: (_) => Test1Bloc(bloc),
      child: const Test1Form(),
    );
  }
}
