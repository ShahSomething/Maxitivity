import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:maxitivity/app/app.logger.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:maxitivity/ui/common/app_colors.dart';

class NotificationService {
  static final log = getLogger('NotificationService');
  // final LocalStorageService _localStorageService =
  //     locator<LocalStorageService>();
  final _awesomeNotifications = AwesomeNotifications();
  int get createUniqueId =>
      DateTime.now().millisecondsSinceEpoch.remainder(100000);

  NotificationService() {
    requestPermission();
    initNotifications();
    clearAllNotifications();
    setListeners();
  }

  ///Intialize Awesome Nottifications
  initNotifications() {
    _awesomeNotifications.initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'basic_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Basic channel for notifications',
          defaultColor: AppColors.primaryColor,
          importance: NotificationImportance.Max,
          defaultRingtoneType: DefaultRingtoneType.Alarm,
          channelShowBadge: true,
          playSound: true,
          enableVibration: true,
          locked: true,
          ledColor: AppColors.whiteColor,
          criticalAlerts: true,
        ),
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'basic_group',
          channelGroupName: 'Basic group',
        ),
      ],
    );
  }

  ///Request Notification Permission
  requestPermission() async {
    //if (_localStorageService.isPermissionsAsked) return;
    bool isAllowed = await _awesomeNotifications.isNotificationAllowed();
    if (!isAllowed) {
      // This is just a basic example. For real apps, you must show some
      // friendly dialog box before call the request method.
      // This is very important to not harm the user experience
      _awesomeNotifications.requestPermissionToSendNotifications();
      //_localStorageService.setPermissionsAsked = true;
    }
  }

  ///Clears the badge and notification trey
  clearAllNotifications() {
    _awesomeNotifications.dismissAllNotifications();
    _awesomeNotifications.setGlobalBadgeCounter(0);
  }

  ///Set all notification listeners
  setListeners() {
    _awesomeNotifications.setListeners(
      onActionReceivedMethod: _onActionReceivedMethod,
      onNotificationCreatedMethod: _onNotificationCreatedMethod,
      onNotificationDisplayedMethod: _onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: _onDismissActionReceivedMethod,
    );
  }

  ///Create a notification
  ///notificationSchedule: The time at which you want to send Notification. Example: NotificationCalendar.fromDate(date: scheduleTime)
  ///category: Example NotificationCategory.Reminder
  createLocalNotification({
    required int id,
    required String channelKey,
    String? title,
    String? body,
    ActionType actionType = ActionType.DismissAction,
    bool wakeUpScreen = true,
    NotificationSchedule? notificationSchedule,
    String summary = 'Notification',
    bool displayOnBackground = true,
    bool displayOnForeground = true,
  }) async {
    await _awesomeNotifications.createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey,
        title: title,
        body: body,
        summary: summary,
        actionType: actionType,
        wakeUpScreen: wakeUpScreen,
        category: NotificationCategory.Alarm,
        displayOnBackground: displayOnBackground,
        displayOnForeground: displayOnForeground,
        locked: true,
      ),
      schedule: notificationSchedule,
    );

    log.i('@createLocalNotification: Notification Created');
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> _onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    FlutterRingtonePlayer.playAlarm(
      looping: true,
      asAlarm: true,
    );
    log.i('@_onNotificationCreatedMethod: Notification Created');

    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> _onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // FlutterRingtonePlayer.playAlarm();
    // log.i('@_onNotificationDisplayedMethod: Notification Displayed');
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> _onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    log.i('@_onDismissActionReceivedMethod: Notification Dismissed');
    FlutterRingtonePlayer.stop();
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> _onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    log.i('@_onActionReceivedMethod: Notification Action Received');
    FlutterRingtonePlayer.stop();
    // Your code goes here

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil('/notification-page',
    //         (route) => (route.settings.name != '/notification-page') || route.isFirst,
    //     arguments: receivedAction);
  }
}
