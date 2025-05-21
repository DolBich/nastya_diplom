import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/app_data/app_data_bloc.dart';
import 'package:nastya_diplom/application/test_6/test_6_bloc.dart';
import 'package:nastya_diplom/domain/test_6/test_6_unit.dart';
import 'package:nastya_diplom/infrastructure/enum.dart';
import 'package:nastya_diplom/presentation/routes/router.dart';
import 'package:nastya_diplom/presentation/widgets/bloc_text_field.dart';

part 'test_6_form.dart';

@RoutePage()
class Test6Screen extends StatelessWidget {
  const Test6Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppDataBloc>();
    return BlocProvider<Test6Bloc>(
      create: (_) => Test6Bloc(bloc),
      child: const Test6Form(),
    );
  }
}
