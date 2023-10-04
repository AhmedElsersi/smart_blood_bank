import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_blood_bank/src/constants/assets.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/constants/const_variables.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text.dart';
import 'package:smart_blood_bank/src/presentation/widgets/layout/ask_guest_login.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        toolbarHeight: 60.h,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const DefaultText(
          text: 'Notifications',
          textColor: AppColors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        leading: InkWell(
          onTap: () {},
          child: Icon(
            Icons.arrow_back_rounded,
            size: 32.sp,
            color: AppColors.white,
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      body: isGuest
          ? const AskGuestLogin()
          : SingleChildScrollView(
              clipBehavior: Clip.none,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Column(
                  children: List.generate(
                      20,
                      (index) => const NotificationComponent(
                            image: AppAssets.icDonner,
                            userName: "Raed Ali",
                            title: ' liked your ad ',
                            time: "8 mins ago",
                            status: "New",
                          )),
                ),
              ),
            ),
    );
  }
}

class NotificationComponent extends StatelessWidget {
  const NotificationComponent({
    super.key,
    required this.image,
    required this.userName,
    required this.title,
    required this.time,
    required this.status,
  });
  final String image;
  final String userName;
  final String title;
  final String time;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          CircleAvatar(
            radius: 28,
            child: Image.asset(image),
          ),
          SizedBox(
            width: 24.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DefaultText(
                      text: userName,
                      fontSize: 14,
                      textColor: AppColors.tColor1,
                      fontWeight: FontWeight.w500,
                    ),
                    DefaultText(
                      text: title,
                      fontSize: 13,
                      textColor: AppColors.tColor1,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                DefaultText(
                  text: time,
                  fontSize: 13,
                  textColor: AppColors.tColor1,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColors.yellow,
                borderRadius: BorderRadius.circular(8)),
            child: DefaultText(
              text: status,
              fontSize: 14,
              textColor: AppColors.tColor1,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
      Divider(
        color: AppColors.lightGrey,
        height: 20.h,
      )
    ]);
  }
}
