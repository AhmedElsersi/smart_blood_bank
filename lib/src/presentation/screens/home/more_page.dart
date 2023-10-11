import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/constants/navigator_extension.dart';
import 'package:smart_blood_bank/src/presentation/router/app_router_names.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text.dart';

import '../../../constants/const_variables.dart';
import '../../../services/cache_helper.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  bool editing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        clipBehavior: Clip.none,
        padding: EdgeInsets.only(bottom: 20.h),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                SingleChildScrollView(
                  clipBehavior: Clip.none,
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Column(children: [
                    Container(
                      height: 180.h,
                      color: AppColors.primary,
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.perm_identity_rounded,
                                color: AppColors.white,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              DefaultText(
                                text: user,
                                textColor: AppColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () {
                        CacheHelper.clearData();
                        context.goTo(AppRouterNames.rLogin);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            color: AppColors.red,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          const DefaultText(
                            text: 'تسجيل خروج',
                            textColor: Color(0xFF1E1E1E),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
