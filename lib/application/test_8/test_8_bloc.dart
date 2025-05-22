import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/application/app_data/app_data_bloc.dart';
import 'package:nastya_diplom/application/audio.dart';
import 'package:nastya_diplom/application/selection/selection_bloc.dart';
import 'package:nastya_diplom/application/timer.dart';
import 'package:nastya_diplom/domain/data/test_data.dart';
import 'package:nastya_diplom/domain/iterable_ext.dart';
import 'package:nastya_diplom/domain/test_8/sounds.dart';
import 'package:nastya_diplom/infrastructure/enum.dart';

part 'test_8_event.dart';

part 'test_8_state.dart';

class Test8Bloc extends Bloc<Test8Event, Test8State> {
  final AppDataBloc appBloc;
  final AudioPlayerService audioService;
  final TimerService timer;

  Test8Bloc(this.appBloc)
      : audioService = AudioPlayerService(),
        timer = TimerService(),
        super(Test8State.initial()) {
    on<_Init>(_onInit);
    on<_ButtonPressed>(_onButtonPressed);
    on<_UpdateRemainingTime>(_updateRemainingTime);
    on<_Save>(_save);
    on<_Cancel>(_cancel);
    on<_PlayNextBackground>(_playNextBackground);
    on<_HandleSoundEvent>(_handleSoundEvent);
  }

  Future<void> _onInit(_Init event, Emitter<Test8State> emit) async {
    // Проигрываем начальный звук
    audioService.playSound(state.selectedSound);

    // Ждем 2 секунды перед стартом
    await Future.delayed(const Duration(seconds: 2));

    // Запускаем таймер
    timer.start();
    timer.timerStream.listen((dur) {
      final updatedTime = 2 * 60 - timer.duration.inSeconds;
      if (updatedTime <= state.remainingTime - 1) {
        add(const Test8Event.updateRemainingTime());
      }
    });

    // Запускаем фоновое воспроизведение
    add(const Test8Event.playNextBackground());
  }

  Future<void> _playNextBackground(_PlayNextBackground event, Emitter<Test8State> emit) async {
    if (state.isCompleted) return;

    // Выбираем случайный фоновый звук
    final background = BackgroundSoundType.values.randomElement();

    // Запускаем воспроизведение фона
    audioService.playBackground(background).listen((status) {
      if (status == PlayerState.completed) {
        // Перезапускаем следующий фон
        add(const Test8Event.playNextBackground());
      }
    });

    emit(state.copyWith(
      currentBackground: background,
    ));
  }

  Future<void> _handleSoundEvent(_HandleSoundEvent event, Emitter<Test8State> emit) async {
    // Проигрываем звук события
    audioService.playSound(event.sound.type).listen((status) async {
      if (status == PlayerState.completed) {
        await Future.delayed(const Duration(seconds: 1)).whenComplete(() {
          emit(state.copyWith(
            activeSoundEvent: null,
          ));
        });
      }
    });
  }

  Future<void> _onButtonPressed(_ButtonPressed event, Emitter<Test8State> emit) async {
    if (state.isCompleted) return;

    bool isError = true;
    final currentTime = state.remainingTime;

    // Ищем активное событие в текущий момент
    final activeEvent = state.soundEvents.firstWhereOrNull((e) => e.isActiveAt(currentTime));

    if (activeEvent != null) {
      isError = activeEvent.type != state.selectedSound;

      // Обновляем список событий
      final updatedEvents = state.soundEvents.map((e) {
        if (e == activeEvent) {
          return e.copyWith(wrong: isError);
        }
        return e;
      }).toList();

      emit(state.copyWith(
        soundEvents: updatedEvents,
        errorsCount: state.errorsCount + (isError ? 1 : 0),
        showFeedback: true,
      ));
    } else {
      emit(state.copyWith(
        errorsCount: state.errorsCount + 1,
        showFeedback: true,
      ));
    }

    await Future.delayed(const Duration(milliseconds: 200));
    emit(state.copyWith(showFeedback: false));
  }

  Future<void> _save(_Save event, Emitter<Test8State> emit) async {
    final missedErrors = state.soundEvents.where((e) => e.type == state.selectedSound && e.wrong).length;

    final totalErrors = state.errorsCount + missedErrors;
    final duration = timer.duration;

    timer.dispose();
    audioService.dispose();

    appBloc.add(AppDataEvent.updateTest8Data(
      TestData(errorsCount: totalErrors, duration: duration),
    ));
  }

  Future<void> _updateRemainingTime(_UpdateRemainingTime event, Emitter<Test8State> emit) async {
    final updatedTime = 2 * 60 - timer.duration.inSeconds;
    emit(state.copyWith(
      remainingTime: updatedTime,
    ));

    if (state.soundEvents.any((e) => e.timestamp == updatedTime) && state.activeSoundEvent == null) {
      final sound = state.soundEvents.firstWhere((e) => e.timestamp == updatedTime);
      emit(state.copyWith(
        activeSoundEvent: sound,
      ));
      add(Test8Event.handleSoundEvent(sound));
    }
  }

  Future<void> _cancel(_Cancel event, Emitter<Test8State> emit) async {
    audioService.dispose();
    timer.dispose();
  }
}
