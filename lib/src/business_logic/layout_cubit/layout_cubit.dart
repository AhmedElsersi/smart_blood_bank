import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_blood_bank/src/constants/const_methods.dart';
import 'package:smart_blood_bank/src/constants/end_points.dart';
import 'package:smart_blood_bank/src/models/ads_model.dart';
import 'package:smart_blood_bank/src/models/featured_suppliers_model.dart';
import 'package:smart_blood_bank/src/models/search_places_model.dart';
import 'package:smart_blood_bank/src/models/service_model.dart';
import 'package:smart_blood_bank/src/models/services_model.dart';
import 'package:smart_blood_bank/src/presentation/screens/home/home_page.dart';
import 'package:smart_blood_bank/src/presentation/screens/home/noyifications_page.dart';
import 'package:smart_blood_bank/src/presentation/screens/home/profile_page.dart';
import 'package:smart_blood_bank/src/presentation/screens/home/suppliers_page.dart';
import 'package:smart_blood_bank/src/services/dio_helper.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  static LayoutCubit get(BuildContext context) => BlocProvider.of(context);

  int pageIndex = 3;

  void changePageIndex(int index) {
    pageIndex = index;
    emit(PagedChanged());
  }

  List<Widget> layoutPages = [
    const NotificationsPage(),
    const SuppliersPage(),
    const ProfilePage(),
    const HomePage(),
  ];

  void openDrawer() {
    emit(DrawerOpened());
  }

  int activeDot = 0;
  void putActiveDot(int index) {
    activeDot = index;
    emit(ChangeActiveDot());
  }

  List<AdsModel> ads = [];
  Future getAds() async {
    ads.clear();
    try {
      emit(GetAdsLoading());
      await DioHelper.getData(
        url: EndPoints.epGetAds,
      ).then((value) {
        logSuccess('GetAds Response : ${value.data}');
        List<dynamic> jsonList = value.data;
        ads = jsonList.map((json) => AdsModel.fromJson(json)).toList();
        logSuccess('GetAds Response : ${ads.length}');
        emit(GetAdsSuccess());
      });
    } catch (e) {
      emit(GetAdsFailure());
    }
  }

  List<ServicesModel> machines = [];
  List<ServicesModel> materials = [];
  List<ServicesModel> products = [];
  List<ServicesModel> invOffers = [];
  List<ServicesModel> servicesJobs = [];
  int categoryId = 0;
  void changeCatId(int id) {
    categoryId = id;
    emit(ChangeCategory());
  }

  Future getHomeSection({required num type}) async {
    machines.clear();
    materials.clear();
    products.clear();
    invOffers.clear();
    servicesJobs.clear();
    try {
      emit(GetServicesLoading());
      await DioHelper.getData(
          url: EndPoints.epGetServices, query: {'TypeId': type}).then((value) {
        logSuccess('getHomeSection Response : ${value.data}');
        List<dynamic> jsonList = value.data;
        switch (type) {
          case 1:
            machines =
                jsonList.map((json) => ServicesModel.fromJson(json)).toList();
          case 2:
            materials =
                jsonList.map((json) => ServicesModel.fromJson(json)).toList();
          case 3:
            products =
                jsonList.map((json) => ServicesModel.fromJson(json)).toList();
          case 4:
            invOffers =
                jsonList.map((json) => ServicesModel.fromJson(json)).toList();
          case 5:
            servicesJobs =
                jsonList.map((json) => ServicesModel.fromJson(json)).toList();
          default:
            return;
        }
        emit(GetServicesSuccess());
      });
    } catch (e) {
      emit(GetServicesFailure());
    }
  }

  List<FeaturedSuppliersModel> featuredSuppliers = [];
  Future getFeaturedSuppliers() async {
    featuredSuppliers.clear();
    try {
      emit(GetFeaturedSuppliersLoading());
      await DioHelper.getData(url: EndPoints.epGetFeaturedSuppliers)
          .then((value) {
        logSuccess('getFeaturedSuppliers Response : ${value.data}');
        List<dynamic> jsonList = value.data;
        featuredSuppliers = jsonList
            .map((json) => FeaturedSuppliersModel.fromJson(json))
            .toList();

        emit(GetFeaturedSuppliersSuccess());
      });
    } catch (e) {
      emit(GetFeaturedSuppliersFailure());
    }
  }

  ServiceModel service = ServiceModel();
  Future getServiceById({required double id}) async {
    service = ServiceModel();
    try {
      emit(GetServiceLoading());
      await DioHelper.getData(url: EndPoints.epGetService, query: {'ItmId': id})
          .then((value) {
        logSuccess('getServiceById Response : ${value.data}');
        service = ServiceModel.fromJson(value.data);
        emit(GetServiceSuccess());
      });
    } catch (e) {
      emit(GetServiceFailure());
    }
  }

  List<SearchPlacesModel> searchPlaces = [];
  SearchPlacesModel searchPlace = SearchPlacesModel(place: 'mmm');

  Future getSearchPlaces() async {
    searchPlaces.clear();
    try {
      emit(GetSearchPlacesLoading());
      await DioHelper.getData(url: EndPoints.epGetSearchPlaces).then((value) {
        logSuccess('getSearchPlaces Response : ${value.data}');
        List<dynamic> jsonList = value.data;
        searchPlaces =
            jsonList.map((json) => SearchPlacesModel.fromJson(json)).toList();
        // for(int i=0;i<searchPlaces.length;i++){
        //   places.add(searchPlaces[i].place??'');
        // }
        emit(GetSearchPlacesSuccess());
      });
    } catch (e) {
      emit(GetSearchPlacesFailure());
    }
  }
}
