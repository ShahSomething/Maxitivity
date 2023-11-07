import 'dart:async';
import 'package:maxitivity/app/app.locator.dart';
import 'package:maxitivity/app/enums/timer_state.dart';
import 'package:maxitivity/services/database_service.dart';
import 'package:maxitivity/services/notification_service.dart';
import 'package:stacked/stacked.dart';

class TimerService with ListenableServiceMixin {
  TimerService() {
    listenToReactiveValues([_seconds, _timerState]);
  }
  //Services
  final NotificationService _notificationService =
      locator<NotificationService>();
  final DatabaseService _databaseService = locator<DatabaseService>();

  //Countdown Timer
  late Timer _timer;
  TimerState _timerState = TimerState.stopped;

  int _seconds = 60 * 25;

  //Variables for Pomodoro
  DateTime? _startTime;

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

  set startTime(DateTime value) {
    _startTime = value;
  }

  startTimer() {
    if (_timerState == TimerState.stopped) {
      startTime = DateTime.now();
    }
    if (_timerState == TimerState.stopped || _timerState == TimerState.paused) {
      timerState = TimerState.started;
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (_seconds > 0) {
            seconds = _seconds - 1;
          } else {
            var endTime = DateTime.now();
            stopTimer();
            _notificationService.createLocalNotification(
              id: _notificationService.createUniqueId,
              channelKey: 'basic_channel',
              title: 'Maxitivity',
              body: 'Time to take a break!',
              summary: 'Pomodoro done!',
            );
            _databaseService.createNewPomodoro(
              startTime: _startTime!,
              endTime: endTime,
              durationInSeconds: _seconds,
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
      seconds = 60 * 25;
    }
  }
}
