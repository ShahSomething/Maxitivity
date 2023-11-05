import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxitivity/ui/common/app_colors.dart';

class IconBottomNav extends StatelessWidget {
  const IconBottomNav(
      {super.key,
      required this.text,
      required this.activeIcon,
      required this.inactiveIcon,
      required this.selected,
      required this.onPressed});

  final String text;
  final IconData activeIcon;
  final IconData inactiveIcon;
  final bool selected;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          selected
              ? Icon(
                  activeIcon,
                  color: AppColors.primaryColor,
                  size: 25.sp,
                )
              : Icon(
                  inactiveIcon,
                  color: AppColors.lightGreyColorD,
                  size: 25.sp,
                ),
          // 10.verticalSpace,
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              height: 1.5,
              fontWeight: FontWeight.w400,
              color:
                  selected ? AppColors.primaryColor : AppColors.lightGreyColorD,
            ),
          ),
        ],
      ),
    );
  }
}
