import 'package:flutter/material.dart';
import 'package:truck_monitor/config/colors.dart';
import 'package:remixicon/remixicon.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    Key? key,
    this.title,
    this.screen,
    this.isMainTab = true,
    this.onTapped,
    this.index,
  }) : super(key: key);
  final String? title;
  final dynamic screen, onTapped;
  final bool isMainTab;
  final int? index;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!) : appbarTitle(index),
      centerTitle: true,
      backgroundColor: AppColors.kPrimaryColor,
      leading: !isMainTab
          ? GestureDetector(
              onTap: onTapped,
              child: const Icon(Remix.arrow_left_line),
            )
          : const SizedBox.shrink(),
    );
  }
}

appbarTitle(index) {
  switch (index) {
    case 0:
      return const Text('Homepage');
    // case 1:
    //   return const Text('Hire Driver');
    case 1:
      return const Text('Communication');
    case 2:
      return const Text('Profile');
  }
}
