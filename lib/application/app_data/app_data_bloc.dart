import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/app_history/app_history_bloc.dart';
import 'package:nastya_diplom/domain/data/test_data.dart';


part 'app_data_event.dart';
part 'app_data_state.dart';

class AppDataBloc extends Bloc<AppDataEvent, AppDataState> {
  final AppHistoryBloc historyBloc;

  AppDataBloc(this.historyBloc) : super(historyBloc.state.appDataState){
    on<_UpdateTest1Data>(_updateTest1Data);
    on<_UpdateTest2Data>(_updateTest2Data);
    on<_UpdateTest3Data>(_updateTest3Data);
    on<_UpdateTest4Data>(_updateTest4Data);
    on<_UpdateTest5Data>(_updateTest5Data);
    on<_UpdateTest6Data>(_updateTest6Data);
    on<_UpdateTest7Data>(_updateTest7Data);
    on<_UpdateTest8Data>(_updateTest8Data);
    on<_UpdateTest9Data>(_updateTest9Data);
  }

  Future<void> _updateTest9Data(_UpdateTest9Data event, Emitter<AppDataState> emit) async {
    emit(state.copyWith(
      test9data: event.data,
    ));
    historyBloc.add(AppHistoryEvent.updateTest9DataHistory(event.data));
  }

  Future<void> _updateTest8Data(_UpdateTest8Data event, Emitter<AppDataState> emit) async {
    emit(state.copyWith(
      test8data: event.data,
    ));
    historyBloc.add(AppHistoryEvent.updateTest8DataHistory(event.data));
  }

  Future<void> _updateTest7Data(_UpdateTest7Data event, Emitter<AppDataState> emit) async {
    emit(state.copyWith(
      test7data: event.data,
    ));
    historyBloc.add(AppHistoryEvent.updateTest7DataHistory(event.data));
  }

  Future<void> _updateTest6Data(_UpdateTest6Data event, Emitter<AppDataState> emit) async {
    emit(state.copyWith(
      test6data: event.data,
    ));
    historyBloc.add(AppHistoryEvent.updateTest6DataHistory(event.data));
  }

  Future<void> _updateTest5Data(_UpdateTest5Data event, Emitter<AppDataState> emit) async {
    emit(state.copyWith(
      test5data: event.data,
    ));
    historyBloc.add(AppHistoryEvent.updateTest5DataHistory(event.data));
  }

  Future<void> _updateTest4Data(_UpdateTest4Data event, Emitter<AppDataState> emit) async {
    emit(state.copyWith(
      test4data: event.data,
    ));
    historyBloc.add(AppHistoryEvent.updateTest4DataHistory(event.data));
  }

  Future<void> _updateTest3Data(_UpdateTest3Data event, Emitter<AppDataState> emit) async {
    emit(state.copyWith(
      test3data: event.data,
    ));
    historyBloc.add(AppHistoryEvent.updateTest3DataHistory(event.data));
  }

  Future<void> _updateTest2Data(_UpdateTest2Data event, Emitter<AppDataState> emit) async {
    emit(state.copyWith(
      test2data: event.data,
    ));
    historyBloc.add(AppHistoryEvent.updateTest2DataHistory(event.data));
  }

  Future<void> _updateTest1Data(_UpdateTest1Data event, Emitter<AppDataState> emit) async {
    emit(state.copyWith(
      test1data: event.data,
    ));
    historyBloc.add(AppHistoryEvent.updateTest1DataHistory(event.data));
  }
}