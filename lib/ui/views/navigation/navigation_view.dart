import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxitivity/ui/common/app_colors.dart';
import 'package:maxitivity/ui/views/history/history_view.dart';
import 'package:maxitivity/ui/views/timer/timer_view.dart';
import 'package:stacked/stacked.dart';

import 'navigation_viewmodel.dart';

class NavigationView extends StackedView<NavigationViewModel> {
  const NavigationView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    NavigationViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: getViewForIndex(viewModel.currentIndex),
      ),
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: viewModel.currentIndex,
        onTap: viewModel.setIndex,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.whiteColor,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.timer_outlined,
              size: 30.sp,
            ),
            label: 'Timer',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
              size: 30.sp,
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 30.sp,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const TimerView();
      case 1:
        return const HistoryView();
      case 2:
        return Container();
      default:
        return const TimerView();
    }
  }

  @override
  NavigationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      NavigationViewModel();
}
