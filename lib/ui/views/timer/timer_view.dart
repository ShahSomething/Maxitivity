import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxitivity/ui/common/app_colors.dart';
import 'package:maxitivity/ui/common/app_images.dart';
import 'package:maxitivity/ui/widgets/common/circular_filled_button/circular_filled_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:stacked/stacked.dart';

import 'timer_viewmodel.dart';

class TimerView extends StackedView<TimerViewModel> {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TimerViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Timer',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 1.sw,
              height: 380,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  CircularPercentIndicator(
                    radius: 140.0,
                    lineWidth: 7.0,
                    percent: viewModel.seconds / (60 * 25),
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 'appIcon',
                          child: Image.asset(
                            AppImages.appIcon,
                            width: 70,
                            height: 70,
                            color: AppColors.whiteColor,
                          ),
                        ),
                        Text(
                          viewModel.formatedTime(),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: AppColors.primaryColor,
                    backgroundColor: AppColors.backgoundColorDark,
                  ),
                  AnimatedPositioned(
                    left: 0,
                    bottom: viewModel.showStopButton ? 80 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: AnimatedOpacity(
                      opacity: viewModel.showStopButton ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: CircularFilledButton(
                        color: AppColors.errorColor,
                        text: 'Stop',
                        onPressed: viewModel.stopTimer,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: AnimatedOpacity(
                      opacity: viewModel.showStartButton ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: CircularFilledButton(
                        color: AppColors.successColor,
                        text: 'Start',
                        onPressed: viewModel.startTimer,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    right: 0,
                    bottom: (viewModel.showResumeButton ||
                            viewModel.showPauseButton)
                        ? 80
                        : 0,
                    duration: const Duration(milliseconds: 300),
                    child: AnimatedOpacity(
                      opacity: (viewModel.showResumeButton ||
                              viewModel.showPauseButton)
                          ? 1
                          : 0,
                      duration: const Duration(milliseconds: 300),
                      child: CircularFilledButton(
                        color: viewModel.showPauseButton
                            ? AppColors.primaryColor
                            : AppColors.successColor,
                        text: viewModel.showPauseButton ? 'Pause' : 'Resume',
                        onPressed: viewModel.showPauseButton
                            ? viewModel.pauseTimer
                            : viewModel.startTimer,
                      ),
                    ),
                  )
                ],
              ),
            ),
            20.verticalSpace,
            Hero(
              tag: 'appName',
              child: Text(
                'Maxitivity',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  TimerViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TimerViewModel();
}
