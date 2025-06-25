part of 'custom_screen.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({super.key});

  AppBar get _appBar {
    return AppBar(
      title: const Text('Custom title'),
      actions: [
        BlocBuilder<CustomBloc, CustomState>(
          buildWhen: (p, c) =>
              p.isRefreshing != c.isRefreshing || p.isPreview != c.isPreview || p.hasChanges != c.hasChanges,
          builder: (context, state) {
            if (state.isRefreshing) return const CircularProgressIndicator();

            final bloc = context.read<CustomBloc>();

            return Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                _refreshButton(context),
                _previewButton(context),
                if (!state.isPreview) _saveButton(bloc),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _saveButton(CustomBloc bloc) {
    return IconButton(
      onPressed: bloc.state.hasChanges
          ? () {
              bloc.add(const CustomEvent.save());
            }
          : null,
      icon: const Icon(Icons.save_outlined),
    );
  }

  Widget _refreshButton(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final bloc = context.read<CustomBloc>();
        final state = bloc.state;
        if(state.hasChanges) {
          final confirm = await confirmDialog(context, state.count, state.initialCount);

          if(confirm ?? false) {
            bloc.add(const CustomEvent.refresh());
          }
        }

        bloc.add(const CustomEvent.refresh());
      },
      icon: const Icon(Icons.refresh),
    );
  }

  Widget _previewButton(BuildContext context) {
    final bloc = context.read<CustomBloc>();
    return IconButton(
      onPressed: () async {
        final bloc = context.read<CustomBloc>();
        final state = bloc.state;
        if(state.hasChanges) {
          final confirm = await confirmDialog(context, state.count, state.initialCount);

          if(confirm ?? false) {
            bloc.add(const CustomEvent.refresh());
          }
        }

        bloc.add(const CustomEvent.changePreview());
      },
      icon: Icon(bloc.state.isPreview ? Icons.edit_outlined : Icons.preview_outlined),
    );
  }

  Widget get _floatingActionButton {
    return BlocBuilder<CustomBloc, CustomState>(
      buildWhen: (p, c) => p.isPreview != c.isPreview || p.isRefreshing != c.isRefreshing,
      builder: (context, state) {
        if (state.isRefreshing || state.isPreview) return const SizedBox();

        return FloatingActionButton(
          onPressed: () {
            final bloc = context.read<CustomBloc>();
            bloc.add(const CustomEvent.buttonPushed());
          },
          child: const Icon(Icons.add),
        );
      },
    );
  }

  Widget get _body {
    return BlocBuilder<CustomBloc, CustomState>(
      buildWhen: (p, c) => p.isRefreshing != c.isRefreshing,
      builder: (context, state) {
        if (state.isRefreshing) return const Center(child: CircularProgressIndicator());

        final textStyle = Theme.of(context).textTheme.titleLarge; // Хуйня собачья

        return Center(
          child: BlocBuilder<CustomBloc, CustomState>(
            buildWhen: (p, c) => p.count != c.count,
            builder: (context, state) {
              return Text(
                state.count.toString(),
                style: textStyle,
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body,
      floatingActionButton: _floatingActionButton,
    );
  }
}
