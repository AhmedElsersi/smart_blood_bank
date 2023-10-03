import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masnaay/src/constants/assets.dart';
import 'package:masnaay/src/constants/colors.dart';

import 'drawer.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  List<String> iconList = [
    AppAssets.icNotifications,
    AppAssets.icFavorite,
    AppAssets.icProfile,
    AppAssets.icHome,
  ];
  final GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      body: Container(),
      extendBodyBehindAppBar: true,
      drawer: SizedBox(
        width: (MediaQuery.of(context).size.width * 0.75) + 30.w,
        child: Stack(
          children: [
            const DrawerScreen(),
            Positioned(
              top: 26.h,
              left: (MediaQuery.of(context).size.width * 0.75) - 2,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 30.w,
                  height: 30.w,
                  color: AppColors.gradientDark.withOpacity(0.79),
                  child: const Icon(
                    Icons.close_rounded,
                    size: 28,
                    color: AppColors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
