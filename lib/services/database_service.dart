import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:maxitivity/app/app.locator.dart';
import 'package:maxitivity/app/app.logger.dart';
import 'package:maxitivity/models/pomodoro.dart';
import 'package:maxitivity/models/request_response.dart';
import 'package:maxitivity/services/api_service.dart';
import 'package:maxitivity/ui/common/app_endpoints.dart';
import 'package:stacked/stacked.dart';

class DatabaseService with ListenableServiceMixin {
  DatabaseService() {
    listenToReactiveValues([_pomodoros, _loading]);
    getMyPomodoros();
  }
  final logger = getLogger('DatabaseService');
  final ApiService _apiService = locator<ApiService>();
  final deviceInfo = DeviceInfoPlugin();

  List<Pomodoro> _pomodoros = [];
  bool _loading = false;

  List<Pomodoro> get pomodoros => _pomodoros;
  bool get loading => _loading;

  set pomodoros(List<Pomodoro> value) {
    _pomodoros = value;
    _pomodoros.sort((a, b) => b.startTime.compareTo(a.startTime));
    notifyListeners();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  createNewPomodoro(
      {required DateTime startTime,
      required DateTime endTime,
      required int durationInSeconds}) async {
    String userId = await getDeviceId();
    var pomodoro = Pomodoro(
        userId: userId,
        startTime: startTime,
        endTime: endTime,
        durationInSeconds: durationInSeconds);
    RequestResponse response = await _apiService.post(
      endPoint: EndPoints.createPomodoro,
      data: pomodoro.toMap(),
    );

    if (response.success) {
      logger.i(response.data);
      _pomodoros.add(Pomodoro.fromMap(response.data));
      _pomodoros.sort((a, b) => b.startTime.compareTo(a.startTime));
      notifyListeners();
    } else {
      logger.e(response.message);
    }
  }

  getMyPomodoros() async {
    loading = true;
    String userId = await getDeviceId();
    RequestResponse response = await _apiService.get(
      endPoint: "${EndPoints.getMyPomodoros}/$userId",
    );
    if (response.success) {
      logger.i(response.data);
      pomodoros =
          response.data.map<Pomodoro>((e) => Pomodoro.fromMap(e)).toList();
    } else {
      logger.e(response.message);
    }
    loading = false;
  }

  ///returns the device id
  Future<String> getDeviceId() async {
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }
}
