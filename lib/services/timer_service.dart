import 'dart:async';

import 'package:maxitivity/app/enums/timer_state.dart';
import 'package:stacked/stacked.dart';

class TimerService with ListenableServiceMixin {
  TimerService() {
    listenToReactiveValues([_seconds, _timerState]);
  }
  //Countdown Timer
  late Timer _timer;
  TimerState _timerState = TimerState.stopped;

  int _seconds = 60 * 25;

  int get seconds => _seconds;
  TimerState get timerState => _timerState;

  set seconds(int value) {
    _seconds = value;
    notifyListeners();
  }

  set timerState(TimerState value) {
    _timerState = value;
    notifyListeners();
  }

  startTimer() {
    if (_timerState == TimerState.stopped || _timerState == TimerState.paused) {
      timerState = TimerState.started;
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (_seconds > 0) {
            seconds = _seconds - 1;
          } else {
            stopTimer();
          }
        },
      );
    }
  }

  pauseTimer() {
    if (_timerState == TimerState.started) {
      _timer.cancel();
      timerState = TimerState.paused;
    }
  }

  stopTimer() {
    if (_timerState == TimerState.started || _timerState == TimerState.paused) {
      _timer.cancel();
      timerState = TimerState.stopped;
      seconds = 60 * 25;
    }
  }
}
