import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nastya_diplom/application/app_data/app_data_bloc.dart';
import 'package:nastya_diplom/domain/data/test_data.dart';
import 'package:nastya_diplom/domain/history/history_unit.dart';
import 'package:nastya_diplom/domain/profile/profile.dart';
import 'package:nastya_diplom/infrastructure/enum.dart';
import 'package:nastya_diplom/main.dart';

part 'app_history_event.dart';

part 'app_history_state.dart';

part 'app_history_bloc.g.dart';

class AppHistoryBloc extends Bloc<AppHistoryEvent, AppHistoryState> {
  AppHistoryBloc(Map<String, dynamic>? json) : super(AppHistoryState.initial(json)) {
    on<_UpdateProfile>(_updateProfile);
    on<_UpdateTest1DataHistory>(_updateTest1DataHistory);
    on<_UpdateTest2DataHistory>(_updateTest2DataHistory);
    on<_UpdateTest3DataHistory>(_updateTest3DataHistory);
    on<_UpdateTest4DataHistory>(_updateTest4DataHistory);
    on<_UpdateTest5DataHistory>(_updateTest5DataHistory);
    on<_UpdateTest6DataHistory>(_updateTest6DataHistory);
    on<_UpdateTest7DataHistory>(_updateTest7DataHistory);
    on<_UpdateTest8DataHistory>(_updateTest8DataHistory);
    on<_UpdateTest9DataHistory>(_updateTest9DataHistory);
    on<AppHistoryEvent>(_save);
  }

  Future<void> _save(AppHistoryEvent event, Emitter<AppHistoryState> emit) async {
    await saveJsonToFile(
      jsonData: state.toJson(),
      fileName: DATA_FILE_NAME,
    );
  }

  Future<File> saveJsonToFile({
    required Map<String, dynamic> jsonData,
    required String fileName,
    bool useApplicationDirectory = true,
  }) async {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      final jsonString = encoder.convert(jsonData);

      Directory directory = Directory.current;

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final file = File('${directory.path}/$fileName');
      return await file.writeAsString(jsonString);
    } on IOException catch (e) {
      throw Exception('Ошибка записи файла: $e');
    } on JsonUnsupportedObjectError catch (e) {
      throw Exception('Неподдерживаемый тип данных в JSON: ${e.unsupportedObject}');
    } catch (e) {
      throw Exception('Неизвестная ошибка: $e');
    }
  }

  Future<void> _updateTest1DataHistory(_UpdateTest1DataHistory event, Emitter<AppHistoryState> emit) async {
    final List<HistoryUnit> list = List.from(state.test1dataHistory.values.first ?? []);
    list.add(HistoryUnit(
      data: event.data,
      date: DateTime.now(),
    ));
    emit(state.copyWith(
      test1dataHistory: list,
    ));
  }

  Future<void> _updateTest2DataHistory(_UpdateTest2DataHistory event, Emitter<AppHistoryState> emit) async {
    final List<HistoryUnit> list = List.from(state.test2dataHistory.values.first ?? []);
    list.add(HistoryUnit(
      data: event.data,
      date: DateTime.now(),
    ));
    emit(state.copyWith(
      test2dataHistory: list,
    ));
  }

  Future<void> _updateTest3DataHistory(_UpdateTest3DataHistory event, Emitter<AppHistoryState> emit) async {
    final List<HistoryUnit> list = List.from(state.test3dataHistory.values.first ?? []);
    list.add(HistoryUnit(
      data: event.data,
      date: DateTime.now(),
    ));
    emit(state.copyWith(
      test3dataHistory: list,
    ));
  }

  Future<void> _updateTest4DataHistory(_UpdateTest4DataHistory event, Emitter<AppHistoryState> emit) async {
    final List<HistoryUnit> list = List.from(state.test4dataHistory.values.first ?? []);
    list.add(HistoryUnit(
      data: event.data,
      date: DateTime.now(),
    ));
    emit(state.copyWith(
      test4dataHistory: list,
    ));
  }

  Future<void> _updateTest5DataHistory(_UpdateTest5DataHistory event, Emitter<AppHistoryState> emit) async {
    final List<HistoryUnit> list = List.from(state.test5dataHistory.values.first ?? []);
    list.add(HistoryUnit(
      data: event.data,
      date: DateTime.now(),
    ));
    emit(state.copyWith(
      test5dataHistory: list,
    ));
  }

  Future<void> _updateTest6DataHistory(_UpdateTest6DataHistory event, Emitter<AppHistoryState> emit) async {
    final List<HistoryUnit> list = List.from(state.test6dataHistory.values.first ?? []);
    list.add(HistoryUnit(
      data: event.data,
      date: DateTime.now(),
    ));
    emit(state.copyWith(
      test6dataHistory: list,
    ));
  }

  Future<void> _updateTest7DataHistory(_UpdateTest7DataHistory event, Emitter<AppHistoryState> emit) async {
    final List<HistoryUnit> list = List.from(state.test7dataHistory.values.first ?? []);
    list.add(HistoryUnit(
      data: event.data,
      date: DateTime.now(),
    ));
    emit(state.copyWith(
      test7dataHistory: list,
    ));
  }

  Future<void> _updateTest8DataHistory(_UpdateTest8DataHistory event, Emitter<AppHistoryState> emit) async {
    final List<HistoryUnit> list = List.from(state.test8dataHistory.values.first ?? []);
    list.add(HistoryUnit(
      data: event.data,
      date: DateTime.now(),
    ));
    emit(state.copyWith(
      test8dataHistory: list,
    ));
  }

  Future<void> _updateTest9DataHistory(_UpdateTest9DataHistory event, Emitter<AppHistoryState> emit) async {
    final List<HistoryUnit> list = List.from(state.test9dataHistory.values.first ?? []);
    list.add(HistoryUnit(
      data: event.data,
      date: DateTime.now(),
    ));
    emit(state.copyWith(
      test9dataHistory: list,
    ));
  }

  Future<void> _updateProfile(_UpdateProfile event, Emitter<AppHistoryState> emit) async {
    emit(state.copyWith(
      profile: event.profile,
    ));
  }
}
