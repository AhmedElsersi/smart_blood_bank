import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/constants/end_points.dart';
import 'package:smart_blood_bank/src/models/services_model.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text_field.dart';

import '../../../business_logic/auth_cubit/auth_cubit.dart';
import '../../../business_logic/layout_cubit/layout_cubit.dart';
import '../../../constants/assets.dart';
import '../../widgets/default_text.dart';
import '../../widgets/dot.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    LayoutCubit.get(context).getAds();
    for (int i = 0; i < 5; i++) {
      LayoutCubit.get(context).getHomeSection(type: i + 1);
    }
    AuthCubit.get(context).getIndustries();
    AuthCubit.get(context).getInterests();
    super.initState();
  }

  List<CategoryModel> categories = [
    const CategoryModel(id: 1, title: "Renting Machine"),
    const CategoryModel(id: 2, title: "Industrial Scrap"),
    const CategoryModel(id: 3, title: "Services / Jobs"),
    const CategoryModel(id: 4, title: "Investment Offers"),
    const CategoryModel(id: 5, title: "Products"),
  ];
  int adsActiveDot = 0;
  void putAdsActiveDot(int index) {
    setState(() {
      adsActiveDot = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = LayoutCubit.get(context);
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.primary,
              toolbarHeight: 65.h,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: DefaultTextField(
                controller: _searchController,
                keyboardType: TextInputType.name,
                hintText: 'search',
                hintTextColor: AppColors.tColor1,
                textColor: AppColors.tColor1,
                height: 30.h,
                borderRadius: 12,
                color: AppColors.white,
                prefix: const Icon(
                  Icons.search_rounded,
                  color: AppColors.tColor1,
                ),
              ),
              leading: InkWell(
                onTap: () {
                  cubit.openDrawer();
                },
                child: Icon(
                  Icons.menu_rounded,
                  size: 32.sp,
                  color: AppColors.white,
                ),
              ),
            ),
            body: SingleChildScrollView(
              clipBehavior: Clip.none,
              child: Column(
                children: [
                  state is GetAdsLoading || cubit.ads.isEmpty
                      ? const SizedBox(
                          height: 150,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        )
                      : Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            CarouselSlider(
                              key: const ValueKey(0),
                              options: CarouselOptions(
                                onPageChanged: (index, reason) {
                                  putAdsActiveDot(index);
                                },
                                viewportFraction: 1,
                                autoPlay: true,
                                height: 150,
                              ),
                              items: cubit.ads.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return InkWell(
                                      onTap: () {
                                        // logSuccess("lll${cubit.ads.length}");
                                      },
                                      child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 24.w, vertical: 10.h),
                                          height: 150,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Image.network(
                                            "${EndPoints.imageBaseUrl}${i.aImgUrl}",
                                            fit: BoxFit.fill,
                                          )),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            Positioned(
                              bottom: 16.h,
                              child: BlocBuilder<LayoutCubit, LayoutState>(
                                builder: (context, state) {
                                  return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        cubit.ads.length,
                                        (index) => Dot(
                                            key: ValueKey(0 + index),
                                            color: AppColors.white
                                                .withOpacity(0.5),
                                            activeColor: AppColors.white,
                                            height: 6.h,
                                            width: 6.h,
                                            isActive: adsActiveDot == index),
                                      ).toList());
                                },
                              ),
                            ),
                          ],
                        ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 28.w, vertical: 5.h),
                        child: const DefaultText(
                          text: 'Categories',
                          textAlign: TextAlign.left,
                          textColor: AppColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          CarouselSlider(
                            key: const ValueKey(1),
                            options: CarouselOptions(
                              onPageChanged: (index, reason) {
                                BlocProvider.of<LayoutCubit>(context)
                                    .putActiveDot(index);
                              },
                              viewportFraction: 1.2,
                              autoPlay: false,
                              height: 150,
                            ),
                            items: categories.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return InkWell(
                                    onTap: () {
                                      cubit.categoryId = i.id;
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(AppAssets.icDonner),
                                        Image.asset(AppAssets.icDonner),
                                        DefaultText(
                                          text: i.title,
                                          textAlign: TextAlign.center,
                                          textColor: AppColors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          Positioned(
                            bottom: 16.h,
                            child: BlocBuilder<LayoutCubit, LayoutState>(
                              builder: (context, state) {
                                return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      categories.length,
                                      (index) => Dot(
                                          key: ValueKey(1 + index),
                                          color:
                                              AppColors.white.withOpacity(0.5),
                                          activeColor: AppColors.white,
                                          height: 6.h,
                                          width: 6.h,
                                          isActive:
                                              BlocProvider.of<LayoutCubit>(
                                                          context)
                                                      .activeDot ==
                                                  index),
                                    ).toList());
                              },
                            ),
                          ),
                        ],
                      ),
                      CategorySection(
                        key: const ValueKey(1),
                        title: 'Renting Machines',
                        seeAllExist: true,
                        isSectionPadded: false,
                        isItemsPadded: false,
                        services: cubit.machines,
                        state: state,
                        onTapSeeAll: () {
                          cubit.changeCatId(1);
                        },
                      ),
                      CategorySection(
                        key: const ValueKey(2),
                        title: 'Industrial Scrap',
                        seeAllExist: true,
                        isSectionPadded: false,
                        isItemsPadded: false,
                        services: cubit.materials,
                        state: state,
                        onTapSeeAll: () {
                          cubit.changeCatId(2);
                        },
                      ),
                      CategorySection(
                        key: const ValueKey(3),
                        title: 'Services/Jobs',
                        seeAllExist: true,
                        isSectionPadded: false,
                        isItemsPadded: false,
                        services: cubit.servicesJobs,
                        state: state,
                        onTapSeeAll: () {
                          cubit.changeCatId(5);
                        },
                      ),
                      CategorySection(
                        key: const ValueKey(4),
                        title: 'Investment Offers',
                        seeAllExist: true,
                        isSectionPadded: false,
                        isItemsPadded: false,
                        services: cubit.invOffers,
                        state: state,
                        onTapSeeAll: () {
                          cubit.changeCatId(4);
                        },
                      ),
                      CategorySection(
                        key: const ValueKey(5),
                        title: 'Products',
                        seeAllExist: true,
                        isSectionPadded: false,
                        isItemsPadded: false,
                        services: cubit.products,
                        state: state,
                        onTapSeeAll: () {
                          cubit.changeCatId(3);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class CategorySection extends StatelessWidget {
  const CategorySection({
    super.key,
    required this.isSectionPadded,
    required this.title,
    this.titleFontWeight,
    this.titleColor,
    this.titleFontSize,
    required this.seeAllExist,
    this.onTapSeeAll,
    required this.services,
    required this.isItemsPadded,
    this.onTapItem,
    required this.state,
  });
  final bool isSectionPadded;
  final String title;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final Color? titleColor;
  final bool seeAllExist;
  final void Function()? onTapSeeAll;
  final List<ServicesModel> services;
  final bool isItemsPadded;
  final void Function()? onTapItem;

  final LayoutState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: isSectionPadded
              ? EdgeInsets.zero
              : EdgeInsets.symmetric(horizontal: 28.w, vertical: 5.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DefaultText(
                text: title,
                textColor: titleColor ?? AppColors.black,
                fontSize: titleFontSize ?? 18,
                fontWeight: titleFontWeight ?? FontWeight.bold,
              ),
              if (seeAllExist)
                DefaultText(
                  text: 'See All',
                  textColor: AppColors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  onTap: onTapSeeAll,
                ),
            ],
          ),
        ),
        SizedBox(
          height: 190.h,
          child: state is GetServicesLoading || services.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: services.length,
                  padding: isItemsPadded
                      ? EdgeInsets.zero
                      : EdgeInsets.symmetric(horizontal: 24.w),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      // context.goTo(AppRouterNames.rService);
                    },
                    child: MachineCard(
                      serviceModel: services[index],
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

class MachineCard extends StatelessWidget {
  const MachineCard({
    super.key,
    required this.serviceModel,
  });
  final ServicesModel serviceModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // context.goTo(AppRouterNames.rService, args: serviceModel);
      },
      child: Container(
        width: 170,
        height: 160,
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
        ),
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 3),
                blurRadius: 6,
                color: AppColors.black.withOpacity(0.16))
          ],
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                    width: 139,
                    height: 84,
                    child: Image.network(
                      '${EndPoints.imageBaseUrl}${serviceModel.imLocation}',
                      fit: BoxFit.cover,
                    ))),
            SizedBox(
              height: 10.h,
            ),
            DefaultText(
              text: serviceModel.name ?? '',
              textColor: AppColors.black,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Flexible(
                        child: FittedBox(
                          child: DefaultText(
                            text: "EGP ${serviceModel.price ?? ''}",
                            textColor: AppColors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Flexible(
                        child: FittedBox(
                          child: DefaultText(
                            text:
                                'per ${serviceModel.unit!.startsWith('Per') ? serviceModel.unit!.split(' ').last : serviceModel.unit ?? ''}',
                            textColor: AppColors.tColor6,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                InkWell(
                    onTap: () {}, child: SvgPicture.asset(AppAssets.icDonner))
              ],
            ),
            SizedBox(
              height: 6.h,
            ),
            DefaultText(
              text: '${serviceModel.city ?? ''} , ${serviceModel.area ?? ''}',
              textColor: AppColors.tColor7,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 6.h,
            ),
            DefaultText(
              text: serviceModel.date ?? '',
              textColor: AppColors.tColor7,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.title,
  });
  final int id;
  final String title;
}
