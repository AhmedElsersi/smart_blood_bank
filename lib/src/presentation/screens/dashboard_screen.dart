import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_blood_bank/src/constants/assets.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/constants/navigator_extension.dart';
import 'package:smart_blood_bank/src/presentation/router/app_router_names.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_button.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  final List<StaticsModel> statics = [
    StaticsModel(
        icon: AppAssets.icRentingMachine,
        title: 'Renting Machine',
        num: 800,
        color: AppColors.secondary),
    StaticsModel(
        icon: AppAssets.icIndustrial,
        title: 'Industrial Scrap',
        num: 200,
        color: AppColors.lightBlue),
    StaticsModel(
        icon: AppAssets.icServiceJob,
        title: 'Service / Job',
        num: 500,
        color: AppColors.blue2),
    StaticsModel(
        icon: AppAssets.icInvestment,
        title: 'Investment Offers',
        num: 200,
        color: AppColors.midBlue),
    StaticsModel(
        icon: AppAssets.icProducts,
        title: 'Products',
        num: 200,
        color: AppColors.blue),
  ];

  doughnutChart() => SfCircularChart(
        series: <CircularSeries>[
          DoughnutSeries<StaticsModel, String>(
            dataSource: statics,
            xValueMapper: (StaticsModel statics, _) => statics.title,
            yValueMapper: (StaticsModel statics, _) => statics.num,
            pointColorMapper: (StaticsModel statics, _) => statics.color,
            dataLabelSettings: const DataLabelSettings(
              isVisible: false,
            ),
            innerRadius: '80%',
            radius: '100%', // Adjust the radius as needed
          ),
        ],
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        toolbarHeight: 50.h,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const DefaultText(
          text: 'Dashboard',
          textColor: AppColors.white,
          fontSize: 23,
          fontWeight: FontWeight.w500,
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded,
            size: 32.sp,
            color: AppColors.white,
          ),
        ),
      ),
      backgroundColor: AppColors.background2,
      body: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 36,
                    child: Image.asset(AppAssets.imgProfile),
                  ),
                  SizedBox(
                    width: 24.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DefaultText(
                          text: 'Welcome Back',
                          fontSize: 14,
                          textColor: AppColors.tColor1,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        const DefaultText(
                          text: 'userName',
                          fontSize: 13,
                          textColor: AppColors.tColor1,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  const DefaultText(
                    text: 'Edit Profile',
                    fontSize: 14,
                    textColor: AppColors.secondary,
                    fontWeight: FontWeight.w500,
                    textDecoration: TextDecoration.underline,
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),

              /// Statics section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DefaultText(
                    text: 'Statics',
                    fontSize: 17,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 220.h,
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2.2,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                context.goTo(AppRouterNames.rMyServices);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.lightBlue,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: AppColors.blue,
                                        offset: Offset(1, 1),
                                        blurRadius: 2),
                                  ],
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      statics[index].icon,
                                      colorFilter: const ColorFilter.mode(
                                          AppColors.white, BlendMode.srcIn),
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DefaultText(
                                          text: statics[index].title,
                                          fontSize: 13,
                                          textColor: AppColors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        DefaultText(
                                          text: statics[index].num.toString(),
                                          fontSize: 23,
                                          textColor: AppColors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),

              /// Views section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DefaultText(
                    text: 'Views',
                    fontSize: 17,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 170.h,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: doughnutChart(),
                        ),
                        Expanded(
                          flex: 5,
                          child: GridView.builder(
                              padding: EdgeInsets.only(top: 42.h),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 5,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2,
                              ),
                              itemBuilder: (context, index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 8.w,
                                            width: 8.w,
                                            color: statics[index].color,
                                          ),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          DefaultText(
                                            text: statics[index].title,
                                            fontSize: 11,
                                            textColor: AppColors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 12.w,
                                          ),
                                          DefaultText(
                                            text: statics[index].num.toString(),
                                            fontSize: 14,
                                            textColor: AppColors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),

              /// Prospective Clients section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DefaultText(
                    text: 'Prospective Clients',
                    fontSize: 17,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.w, 16.h, 6.w, 10.h),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(11),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(1, 1),
                              blurRadius: 2,
                              color: AppColors.black.withOpacity(0.45))
                        ]),
                    child: Column(
                      children: List.generate(
                        3 + 1,
                        (index) => index == 3
                            ? DefaultButton(
                                height: 35.h,
                                margin:
                                    EdgeInsets.fromLTRB(16.w, 30.h, 16.w, 6.h),
                                buttonColor: AppColors.blue,
                                text: 'Show More',
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                                textColor: AppColors.white,
                                onTap: () {
                                  context
                                      .goTo(AppRouterNames.rProspectiveClients);
                                },
                              )
                            : ClientComponent(
                                divider: index == 2 ? false : true,
                                image: AppAssets.imgProfile,
                                userName: 'Customer 1',
                                industry: 'Industry 1',
                                time: '12/4/2022'),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StaticsModel {
  StaticsModel(
      {required this.icon,
      required this.title,
      required this.color,
      required this.num});
  final String icon;
  final String title;
  final Color color;
  final int num;
}

class ClientComponent extends StatelessWidget {
  const ClientComponent({
    super.key,
    required this.image,
    required this.userName,
    required this.industry,
    required this.time,
    required this.divider,
  });
  final String image;
  final String userName;
  final String industry;
  final String time;
  final bool divider;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 26,
            child: Image.asset(image),
          ),
          SizedBox(
            width: 24.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultText(
                  text: userName,
                  fontSize: 18,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 3.h,
                ),
                DefaultText(
                  text: industry,
                  fontSize: 15,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          DefaultText(
            text: time,
            fontSize: 15,
            textColor: AppColors.black,
            fontWeight: FontWeight.w400,
          )
        ],
      ),
      if (divider)
        Divider(
          color: AppColors.lightGrey,
          height: 20.h,
        )
    ]);
  }
}
