import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxitivity/app/app.bottomsheets.dart';
import 'package:maxitivity/app/app.dialogs.dart';
import 'package:maxitivity/app/app.locator.dart';
import 'package:maxitivity/app/app.router.dart';
import 'package:maxitivity/ui/common/app_theme.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const double _designWidth = 375;
  static const double _designHeight = 812;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(_designWidth, _designHeight),
      builder: (context, _) {
        return MaterialApp(
          initialRoute: Routes.startupView,
          theme: AppTheme.darkTheme,
          themeMode: ThemeMode.dark,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          navigatorKey: StackedService.navigatorKey,
          navigatorObservers: [
            StackedService.routeObserver,
          ],
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
