import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/app_history/app_history_bloc.dart';
import 'package:nastya_diplom/application/selection/selection_bloc.dart';
import 'package:nastya_diplom/infrastructure/enum.dart';
import 'package:nastya_diplom/presentation/routes/router.dart';
import 'package:nastya_diplom/presentation/screens/selection/widgets/app_drawer.dart';
import 'package:nastya_diplom/presentation/screens/selection/widgets/instruction_view.dart';
import 'package:nastya_diplom/presentation/screens/selection/widgets/test_history_view.dart';

part 'selection_form.dart';

@RoutePage()
class SelectionScreen extends StatelessWidget {
  final SelectionState? initState;

  const SelectionScreen({super.key, this.initState});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppHistoryBloc>();
    if(bloc.state.profile == null) {
      context.router.replaceAll([const ProfileRoute()]);
    }
    return BlocProvider<SelectionBloc>(
      create: (_) => SelectionBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<SelectionBloc>();
        final initState = this.initState;
        if (initState != null) bloc.add(SelectionEvent.reset(initState));

        return const SelectionForm();
      }),
    );
  }
}
