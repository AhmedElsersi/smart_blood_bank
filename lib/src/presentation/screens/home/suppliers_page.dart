import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_blood_bank/src/business_logic/layout_cubit/layout_cubit.dart';
import 'package:smart_blood_bank/src/constants/assets.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/constants/const_methods.dart';
import 'package:smart_blood_bank/src/constants/end_points.dart';
import 'package:smart_blood_bank/src/models/featured_suppliers_model.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text.dart';

class SuppliersPage extends StatefulWidget {
  const SuppliersPage({super.key});

  @override
  State<SuppliersPage> createState() => _SuppliersPageState();
}

class _SuppliersPageState extends State<SuppliersPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    LayoutCubit.get(context).getFeaturedSuppliers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = LayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primary,
              toolbarHeight: 75.h,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: const DefaultText(
                text: 'Featured Suppliers',
                textColor: AppColors.white,
                fontSize: 22,
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
              actions: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: SvgPicture.asset(AppAssets.icDonner),
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.white,
            body: SizedBox(
              width: double.infinity,
              // height: 800.h,
              child: state is GetFeaturedSuppliersSuccess
                  ? GridView.builder(
                      clipBehavior: Clip.none,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.h,
                          childAspectRatio: 0.9),
                      padding: EdgeInsets.symmetric(
                          vertical: 16.h, horizontal: 16.w),
                      itemCount: cubit.featuredSuppliers.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          // context.goTo(AppRouterNames.icDonner,
                          //     args: cubit.featuredSuppliers[index]);
                        },
                        child: SupplierComponent(
                            supplier: cubit.featuredSuppliers[index]),
                      ),
                    )
                  : Center(
                      child: const CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
            ),
          );
        });
  }
}

class SupplierComponent extends StatelessWidget {
  const SupplierComponent({
    super.key,
    required this.supplier,
  });
  final FeaturedSuppliersModel supplier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(1000),
            child: SizedBox(
                width: 100,
                height: 100,
                child: Image.network(
                  '${EndPoints.imageBaseUrl}${supplier.uImg}',
                  fit: BoxFit.cover,
                ))),
        SizedBox(
          height: 6.h,
        ),
        DefaultText(
          text: supplier.uName ?? '',
          fontSize: 17,
          textColor: AppColors.black,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(
          height: 6.h,
        ),
        DefaultText(
          // text: cateName(supplier.uTypeId ?? 1),
          text: cateName(1),
          fontSize: 17,
          textColor: AppColors.black,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(
          height: 6.h,
        ),
        RatingBarIndicator(
          rating: double.parse((supplier.uRating ?? 5).toString()),
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: AppColors.yellow2,
          ),
          itemCount: 5,
          itemSize: 18,
          direction: Axis.horizontal,
        ),
      ],
    );
  }
}
