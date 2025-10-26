import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_app/core/theme/colors.dart';
import 'package:market_app/core/theme/styles.dart';

class CustomSearchField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  const CustomSearchField({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
          color: ColorsManager.moreLightGrey,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ColorsManager.grey)),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          const Icon(Icons.search, color: ColorsManager.grey),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: TextStyles.font14DarkBlueMedium,
              decoration: InputDecoration(
                hintText: "Search for a product...",
                hintStyle: TextStyles.font14LightGreyRegular,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
