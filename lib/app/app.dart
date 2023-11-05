import 'package:maxitivity/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:maxitivity/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:maxitivity/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:maxitivity/ui/views/navigation/navigation_view.dart';
import 'package:maxitivity/ui/views/timer/timer_view.dart';
import 'package:maxitivity/services/timer_service.dart';
import 'package:maxitivity/ui/views/history/history_view.dart';
// @stacked-import

@StackedApp(routes: [
  MaterialRoute(page: StartupView),
  MaterialRoute(page: NavigationView),
  MaterialRoute(page: TimerView),
  MaterialRoute(page: HistoryView),
// @stacked-route
], dependencies: [
  LazySingleton(classType: BottomSheetService),
  LazySingleton(classType: DialogService),
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: TimerService),
// @stacked-service
], bottomsheets: [
  StackedBottomsheet(classType: NoticeSheet),
  // @stacked-bottom-sheet
], dialogs: [
  StackedDialog(classType: InfoAlertDialog),
  // @stacked-dialog
], logger: StackedLogger())
class App {}
