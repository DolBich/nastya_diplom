import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/selection/selection_bloc.dart';
import 'package:nastya_diplom/infrastructure/enum.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 280,
      child: Column(
        children: [
          const DrawerHeader(
            child: Text(
              'Тесты',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: TestType.values.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, index) => _DrawerItem(
                testType: TestType.values[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final TestType testType;

  const _DrawerItem({required this.testType});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SelectionBloc, SelectionState, TestType>(
      selector: (state) => state.testType,
      builder: (context, test) {
        final isSelected = test == testType;
        return ListTile(
          leading: Icon(Icons.assignment, color: isSelected ? Theme.of(context).colorScheme.primary : null),
          title: Text(testType.title),
          selected: isSelected,
          selectedTileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          onTap: () {
            final bloc = context.read<SelectionBloc>();
            bloc.add(SelectionEvent.updateTestType(testType));

            if (Scaffold.of(context).isDrawerOpen) {
              Scaffold.of(context).closeDrawer();
            }
          },
        );
      },
    );
  }
}
