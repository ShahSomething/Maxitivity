import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxitivity/ui/common/app_colors.dart';
import 'package:maxitivity/ui/widgets/common/circular_filled_button/circular_filled_button.dart';
import 'package:stacked/stacked.dart';

import 'history_viewmodel.dart';

class HistoryView extends StackedView<HistoryViewModel> {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HistoryViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.only(left: 15.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            tileColor: AppColors.cardColorDark,
            title: Text(
              "Jan 12",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            subtitle: Text(
              "11:00PM - 11:25PM",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            trailing: const CircularFilledButton(
              color: AppColors.successColor,
              text: "25 min",
              padding: 20,
            ),
          );
        },
        separatorBuilder: (context, index) => 10.verticalSpace,
        itemCount: 7,
      ),
    );
  }

  @override
  HistoryViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HistoryViewModel();
}
