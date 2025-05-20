part of 'profile_screen.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  Future<DateTime?> _datePicker(BuildContext context) async {
    final now = DateTime.now().year;
    return showDatePicker(context: context, firstDate: DateTime(now - 100), lastDate: DateTime(now));
  }

  static DateFormat dateFormat = DateFormat.yMMMMd().add_jms();

  Widget _birthDate(ProfileBloc bloc, BuildContext context) {
    return ListTile(
      title: BlocSelector<ProfileBloc, ProfileState, DateTime?>(
        selector: (state) => state.birthDate,
        builder: (context, date) {
          return Text('Дата рождения: ${dateFormat.formatOrNull(date) ?? ' - '}');
        },
      ),
      onTap: () async {
        final date = await _datePicker(context);
        if (date == null) return;
        bloc.add(ProfileEvent.updateBirthDate(date));
      },
    );
  }

  Widget _name(ProfileBloc bloc) {
    return BlocTextField<ProfileBloc, ProfileState, String>(
      labelText: 'Имя',
      onChanged: (value) => bloc.add(ProfileEvent.updateName(value ?? '')),
      bloc: bloc,
      stateValue: (state) => state.name,
      inputToValue: (value) => value,
    );
  }

  Widget _surname(ProfileBloc bloc) {
    return BlocTextField<ProfileBloc, ProfileState, String>(
      labelText: 'Фамилия',
      onChanged: (value) => bloc.add(ProfileEvent.updateSurname(value ?? '')),
      bloc: bloc,
      stateValue: (state) => state.surname,
      inputToValue: (value) => value,
    );
  }

  Widget _floatingActionButton(ProfileBloc bloc) {
    return BlocSelector<ProfileBloc, ProfileState, bool>(
      selector: (state) => state.enableSave,
      builder: (context, enableSave) {
        return Opacity(
          opacity: !enableSave ? 0.5 : 1,
          child: FloatingActionButton.extended(
            label: const Text('Сохранить'),
            onPressed: enableSave
                ? () {
                    bloc.add(const ProfileEvent.save());
                    context.router.replaceAll([SelectionRoute()]);
                  }
                : null,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      floatingActionButton: _floatingActionButton(bloc),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _name(bloc),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _surname(bloc),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _birthDate(bloc, context),
          ),
        ],
      ),
    );
  }
}
