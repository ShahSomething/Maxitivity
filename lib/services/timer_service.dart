import 'dart:async';

import 'package:maxitivity/app/app.locator.dart';
import 'package:maxitivity/app/enums/timer_state.dart';
import 'package:maxitivity/services/notification_service.dart';
import 'package:stacked/stacked.dart';

class TimerService with ListenableServiceMixin {
  TimerService() {
    listenToReactiveValues([_seconds, _timerState]);
  }
  //Services
  final NotificationService _notificationService =
      locator<NotificationService>();

  //Countdown Timer
  late Timer _timer;
  TimerState _timerState = TimerState.stopped;

  int _seconds = 10;

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
            _notificationService.createLocalNotification(
              id: _notificationService.createUniqueId,
              channelKey: 'basic_channel',
              title: 'Maxitivity',
              body: 'Time to take a break!',
              summary: 'Pomodoro done!',
            );
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
      seconds = 10;
    }
  }
}
