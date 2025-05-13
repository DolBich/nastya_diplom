part of 'app_history_bloc.dart';

sealed class AppHistoryEvent {
  const AppHistoryEvent();

  const factory AppHistoryEvent.updateProfile(Profile profile) = _UpdateProfile;

  const factory AppHistoryEvent.updateTest1DataHistory(TestData data) = _UpdateTest1DataHistory;

  const factory AppHistoryEvent.updateTest2DataHistory(TestData data) = _UpdateTest2DataHistory;

  const factory AppHistoryEvent.updateTest3DataHistory(TestData data) = _UpdateTest3DataHistory;

  const factory AppHistoryEvent.updateTest4DataHistory(TestData data) = _UpdateTest4DataHistory;

  const factory AppHistoryEvent.updateTest5DataHistory(TestData data) = _UpdateTest5DataHistory;

  const factory AppHistoryEvent.updateTest6DataHistory(TestData data) = _UpdateTest6DataHistory;

  const factory AppHistoryEvent.updateTest7DataHistory(TestData data) = _UpdateTest7DataHistory;

  const factory AppHistoryEvent.updateTest8DataHistory(TestData data) = _UpdateTest8DataHistory;

  const factory AppHistoryEvent.updateTest9DataHistory(TestData data) = _UpdateTest9DataHistory;
}

class _UpdateTest9DataHistory extends AppHistoryEvent {
  final TestData data;
  const _UpdateTest9DataHistory(this.data);
}

class _UpdateTest8DataHistory extends AppHistoryEvent {
  final TestData data;
  const _UpdateTest8DataHistory(this.data);
}

class _UpdateTest7DataHistory extends AppHistoryEvent {
  final TestData data;
  const _UpdateTest7DataHistory(this.data);
}

class _UpdateTest6DataHistory extends AppHistoryEvent {
  final TestData data;
  const _UpdateTest6DataHistory(this.data);
}

class _UpdateTest5DataHistory extends AppHistoryEvent {
  final TestData data;
  const _UpdateTest5DataHistory(this.data);
}

class _UpdateTest4DataHistory extends AppHistoryEvent {
  final TestData data;
  const _UpdateTest4DataHistory(this.data);
}

class _UpdateTest3DataHistory extends AppHistoryEvent {
  final TestData data;
  const _UpdateTest3DataHistory(this.data);
}

class _UpdateTest2DataHistory extends AppHistoryEvent {
  final TestData data;
  const _UpdateTest2DataHistory(this.data);
}

class _UpdateTest1DataHistory extends AppHistoryEvent {
  final TestData data;
  const _UpdateTest1DataHistory(this.data);
}

class _UpdateProfile extends AppHistoryEvent {
  final Profile profile;
  const _UpdateProfile(this.profile);
}
