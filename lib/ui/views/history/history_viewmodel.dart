import 'package:intl/intl.dart';
import 'package:maxitivity/app/app.locator.dart';
import 'package:maxitivity/models/pomodoro.dart';
import 'package:maxitivity/services/database_service.dart';
import 'package:stacked/stacked.dart';

class HistoryViewModel extends ReactiveViewModel {
  //Services
  final DatabaseService _databaseService = locator<DatabaseService>();

  List<Pomodoro> get pomodoros => _databaseService.pomodoros;
  bool get isLoading => _databaseService.loading;

  //Methods
  //Return formated date like "Jan 01"
  String formatedDate(DateTime date) {
    DateFormat formatter = DateFormat('MMM dd');
    return formatter.format(date);
  }

  //Return formated time like "11:00PM - 11:25PM"
  String formatedTime(DateTime startTime, DateTime endTime) {
    DateFormat formatter = DateFormat('hh:mm a');
    return "${formatter.format(startTime)} - ${formatter.format(endTime)}";
  }

  String getMinutesAndSeconds(int duration) {
    if (duration < 60) {
      return "$duration sec";
    } else if (duration < 3600) {
      return "${(duration / 60).floor()} min";
    } else {
      return "${(duration / 3600).floor()} hr";
    }
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_databaseService];
}
