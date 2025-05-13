import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nastya_diplom/application/app_data/app_data_bloc.dart';
import 'package:nastya_diplom/application/profile/profile_bloc.dart';
import 'package:nastya_diplom/domain/date_format_ext.dart';
import 'package:nastya_diplom/presentation/widgets/bloc_text_field.dart';

part 'profile_form.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppDataBloc>();
    return BlocProvider<ProfileBloc>(
      create: (_) => ProfileBloc(appBloc),
      child: const ProfileForm(),
    );
  }
}
