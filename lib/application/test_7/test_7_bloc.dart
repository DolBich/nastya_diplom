import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/app_data/app_data_bloc.dart';
import 'package:nastya_diplom/application/selection/selection_bloc.dart';
import 'package:nastya_diplom/application/timer.dart';
import 'package:nastya_diplom/domain/data/test_data.dart';
import 'package:nastya_diplom/domain/test_7/test_7_images.dart';
import 'package:nastya_diplom/infrastructure/enum.dart';

part 'test_7_event.dart';

part 'test_7_state.dart';

class Test7Bloc extends Bloc<Test7Event, Test7State> {
  final AppDataBloc appBloc;
  final TimerService timer;

  Test7Bloc(this.appBloc)
      : timer = TimerService(),
        super(Test7State.initial()) {
    on<_Save>(_save);
    on<_Cancel>(_cancel);
    on<_UpdateRemainingTime>(_updateRemainingTime);
    on<_IsEqual>(_isEqual);

    timer.timerStream.listen((duration) {
      add(const Test7Event.updateRemainingTime());
    });
  }

  Future<void> _isEqual(_IsEqual event, Emitter<Test7State> emit) async {
    if(state.isProcessing) return;
    emit(state.copyWith(
      isProcessing: true,
    ));

    final isCorrect = event.isEqual == state.prePrevIsCur;

    final updatedImages = List<Test7Image>.from(state.images);
    updatedImages[state.currentIndex] = state.currentImage.copyWith(
      showCorrect: isCorrect,
      showError: !isCorrect,
    );

    emit(state.copyWith(
      images: updatedImages,
      errorsCount: isCorrect ? state.errorsCount : state.errorsCount + 1,
    ));

    await Future.delayed(const Duration(milliseconds: 500));

    final resetImages = List<Test7Image>.from(updatedImages);
    resetImages[state.currentIndex] = resetImages[state.currentIndex].copyWith(
      showCorrect: false,
      showError: false,
    );

    final nextIndex = state.currentIndex + 1;

    if(nextIndex == 20) {
      add(const Test7Event.save());
      return;
    }

    emit(state.copyWith(
      images: resetImages,
      isProcessing: false,
      currentIndex: nextIndex,
    ));
  }

  Future<void> _updateRemainingTime(_UpdateRemainingTime event, Emitter<Test7State> emit) async {
    final updatedTime = 2 * 60 - timer.duration.inSeconds;

    emit(state.copyWith(
      remainingTime: updatedTime,
    ));
  }

  Future<void> _save(_Save event, Emitter<Test7State> emit) async {
    final duration = timer.duration;
    timer.dispose();
    final errors = state.errorsCount + state.images.length - state.currentIndex;

    emit(state.copyWith(
      shouldNavigate: true,
    ));

    appBloc.add(AppDataEvent.updateTest7Data(
      TestData(errorsCount: state.currentIndex == 19 ? state.errorsCount : errors, duration: duration),
    ));
  }

  Future<void> _cancel(_Cancel event, Emitter<Test7State> emit) async {
    timer.dispose();
  }
}
