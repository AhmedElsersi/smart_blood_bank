import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_blood_bank/src/constants/assets.dart';
import 'package:smart_blood_bank/src/constants/cache_keys.dart';
import 'package:smart_blood_bank/src/constants/navigator_extension.dart';
import 'package:smart_blood_bank/src/localization/app_strings_extension.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text.dart';
import 'package:smart_blood_bank/src/presentation/widgets/dot.dart';
import 'package:smart_blood_bank/src/services/cache_helper.dart';

import '../../../constants/colors.dart';
import '../../router/app_router_names.dart';
import '../../widgets/default_button.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _pageIndex = 0;
  onBoardingData(BuildContext context) => [
        OnBoardingModel(
          image: AppAssets.imgOnBoarding1,
          title: context.omBoardingTitle1,
          subTitle: context.omBoardingSubTitle1,
        ),
        OnBoardingModel(
          image: AppAssets.imgOnBoarding2,
          title: context.omBoardingTitle2,
          subTitle: context.omBoardingSubTitle2,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: Column(
                children: [
                  SizedBox(
                    height: 500.h,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: onBoardingData(context).length,
                      onPageChanged: (index) {
                        _pageIndex = index;
                        setState(() {});
                      },
                      itemBuilder: (context, index) => Column(children: [
                        const Spacer(),
                        SvgPicture.asset(
                          onBoardingData(context)[index].image,
                          height: 350,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              DefaultText(
                                text: onBoardingData(context)[index].title,
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                textColor: AppColors.primary,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 5.h),
                              DefaultText(
                                text: onBoardingData(context)[index].subTitle,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                textColor: AppColors.primary,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                      ]),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        onBoardingData(context).length,
                        (index) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: InkWell(
                                onTap: () => _pageController.animateToPage(
                                    index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease),
                                child: Dot(
                                  isActive: _pageIndex == index,
                                  activeColor: AppColors.red,
                                  color: AppColors.lightGrey,
                                ),
                              ),
                            )),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: _pageIndex == 1 ? 60.w : 12.w),
              child: _pageIndex == 1
                  ? DefaultButton(
                      text: context.startNow,
                      textColor: AppColors.white,
                      fontSize: 21,
                      buttonColor: AppColors.red,
                      radius: 800,
                      height: 30.h,
                      width: 60.w,
                      onTap: () {
                        CacheHelper.saveDataSharedPreference(
                            key: CacheKeys.ckFirstTime, value: false);
                        context.goTo(AppRouterNames.rVerifyPhone);
                      })
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => _pageController.animateToPage(
                              _pageIndex + 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease),
                          child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: AppColors.red,
                                  borderRadius: BorderRadius.circular(800)),
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: AppColors.white,
                              )),
                        ),
                        DefaultButton(
                            text: context.skip,
                            buttonColor: AppColors.transparent,
                            textColor: AppColors.red,
                            radius: 8,
                            height: 30.h,
                            width: 60.w,
                            onTap: () {
                              CacheHelper.saveDataSharedPreference(
                                  key: CacheKeys.ckFirstTime, value: false);
                              context.goTo(AppRouterNames.rVerifyPhone);
                            }),
                      ],
                    ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class OnBoardingModel {
  OnBoardingModel(
      {required this.image, required this.title, required this.subTitle});
  final String image;
  final String title;
  final String subTitle;
}
