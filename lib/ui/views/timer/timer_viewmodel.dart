import 'package:maxitivity/app/app.locator.dart';
import 'package:maxitivity/app/app.logger.dart';
import 'package:maxitivity/app/enums/timer_state.dart';
import 'package:maxitivity/services/timer_service.dart';
import 'package:stacked/stacked.dart';

class TimerViewModel extends ReactiveViewModel {
  //Services
  final logger = getLogger('TimerViewModel');
  final TimerService _timerService = locator<TimerService>();

  int get seconds => _timerService.seconds;
  TimerState get timerState => _timerService.timerState;
  bool get showStartButton => timerState == TimerState.stopped;
  bool get showPauseButton => timerState == TimerState.started;
  bool get showStopButton =>
      timerState == TimerState.started || timerState == TimerState.paused;
  bool get showResumeButton => timerState == TimerState.paused;

  //Methods
  String formatedTime() {
    int minutes = this.seconds ~/ 60;
    int seconds = this.seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  startTimer() {
    _timerService.startTimer();
  }

  stopTimer() {
    _timerService.stopTimer();
  }

  pauseTimer() {
    _timerService.pauseTimer();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_timerService];
}
