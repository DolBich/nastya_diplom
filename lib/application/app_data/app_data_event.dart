part of 'app_data_bloc.dart';

sealed class AppDataEvent {
  const AppDataEvent();

  const factory AppDataEvent.updateTest1Data(TestData data) = _UpdateTest1Data;

  const factory AppDataEvent.updateTest2Data(TestData data) = _UpdateTest2Data;

  const factory AppDataEvent.updateTest3Data(TestData data) = _UpdateTest3Data;

  const factory AppDataEvent.updateTest4Data(TestData data) = _UpdateTest4Data;

  const factory AppDataEvent.updateTest5Data(TestData data) = _UpdateTest5Data;

  const factory AppDataEvent.updateTest6Data(TestData data) = _UpdateTest6Data;

  const factory AppDataEvent.updateTest7Data(TestData data) = _UpdateTest7Data;

  const factory AppDataEvent.updateTest8Data(TestData data) = _UpdateTest8Data;

  const factory AppDataEvent.updateTest9Data(TestData data) = _UpdateTest9Data;
}

class _UpdateTest9Data extends AppDataEvent {
  final TestData data;
  const _UpdateTest9Data(this.data);
}

class _UpdateTest8Data extends AppDataEvent {
  final TestData data;
  const _UpdateTest8Data(this.data);
}

class _UpdateTest7Data extends AppDataEvent {
  final TestData data;
  const _UpdateTest7Data(this.data);
}

class _UpdateTest6Data extends AppDataEvent {
  final TestData data;
  const _UpdateTest6Data(this.data);
}

class _UpdateTest5Data extends AppDataEvent {
  final TestData data;
  const _UpdateTest5Data(this.data);
}

class _UpdateTest4Data extends AppDataEvent {
  final TestData data;
  const _UpdateTest4Data(this.data);
}

class _UpdateTest3Data extends AppDataEvent {
  final TestData data;
  const _UpdateTest3Data(this.data);
}

class _UpdateTest2Data extends AppDataEvent {
  final TestData data;
  const _UpdateTest2Data(this.data);
}

class _UpdateTest1Data extends AppDataEvent {
  final TestData data;
  const _UpdateTest1Data(this.data);
}
