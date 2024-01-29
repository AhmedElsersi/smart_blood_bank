import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_blood_bank/src/models/places_model.dart';

import '../../constants/const_methods.dart';
import '../../constants/end_points.dart';
import '../../models/place_model.dart';
import '../../services/dio_helper.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  PlacesCubit() : super(PlacesInitial());
  static PlacesCubit get(BuildContext context) => BlocProvider.of(context);

  List<PlaceModel> places = [];
  Future getHospitals() async {
    places.clear();
    try {
      emit(GetHospitalsLoading());
      await DioHelper.getData(
        url: EndPoints.epGetHospitals,
      ).then((value) {
        logSuccess('getHospitals Response : ${value.data}');
        final response = PlacesModel.fromJson(value.data);
        places = response.data ?? [];
        emit(GetHospitalsSuccess());
      });
    } on DioError catch (dioError) {
      logError('mmmm ${dioError.response}');
    } catch (e) {
      emit(GetHospitalsFailure());
    }
  }

  PlaceIModel placeModel = PlaceIModel();
  Future getHospital({required int id}) async {
    try {
      emit(GetHospitalLoading());
      await DioHelper.getData(
        url: EndPoints.epGetHospital(id),
      ).then((value) {
        logSuccess('getHospital Response : ${value.data}');
        placeModel = PlaceIModel.fromJson(value.data);

        emit(GetHospitalSuccess());
      });
    } on DioError catch (dioError) {
      logError('mmmm ${dioError.response}');
    } catch (e) {
      emit(GetHospitalFailure());
    }
  }

  Future getBloodBanks() async {
    places.clear();
    try {
      emit(GetBloodBanksLoading());
      await DioHelper.getData(
        url: EndPoints.epGetBloodBanks,
      ).then((value) {
        logSuccess('getBloodBanks Response : ${value.data}');
        final response = PlacesModel.fromJson(value.data);
        places = response.data ?? [];
        emit(GetBloodBanksSuccess());
      });
    } catch (e) {
      emit(GetBloodBanksFailure());
    }
  }

  Future getBloodBank({required int id}) async {
    try {
      emit(GetBloodBankLoading());
      await DioHelper.getData(
        url: EndPoints.epGetBloodBank(id),
      ).then((value) {
        logSuccess('getBloodBank Response : ${value.data}');
        placeModel = PlaceIModel.fromJson(value.data);
        emit(GetBloodBankSuccess());
      });
    } on DioError catch (dioError) {
      logError('mmmm ${dioError.response}');
    } catch (e) {
      emit(GetBloodBankFailure());
    }
  }
}
