part of 'selection_screen.dart';

class SelectionForm extends StatelessWidget {
  const SelectionForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SelectionBloc>();
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<SelectionBloc, SelectionState>(
          builder: (context, state) {
            String text = '';
            final test = state.testType;
            text = test.title;
            if(state.showHistory) {
              text = '$text (История)';
            }
            return Text(text, style: const TextStyle(fontSize: DEFAULT_TEXT_SIZE),);
          },
        ),
        actions: [
          IconButton(
            icon: BlocSelector<SelectionBloc, SelectionState, bool>(
              selector: (state) => state.showHistory,
              builder: (context, showHistory) {
                return showHistory ? const Icon(Icons.text_fields_outlined) : const Icon(Icons.history);
              }
            ),
            onPressed: () => bloc.add(const SelectionEvent.updateShowHistory()),
          ),
          IconButton(
            icon:  const Icon(Icons.account_box_outlined),
            onPressed: () {
              context.router.navigate(const ProfileRoute());
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<SelectionBloc, SelectionState>(builder: (context, state) {
        if(state.showHistory) {
          return TestHistoryView(test: state.testType);
        }

        return InstructionView(testType: state.testType);
      }),
    );
  }
}
