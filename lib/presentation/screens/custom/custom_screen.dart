import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/custom/custom_bloc.dart';
import 'package:nastya_diplom/presentation/screens/custom/dialogs/confirm_dialog.dart';

part 'custom_form.dart';

@RoutePage()
class CustomNameScreen extends StatelessWidget {
  const CustomNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CustomBloc>(
      create: (_) => CustomBloc(),
      child: const CustomForm(),
    );
  }
}
