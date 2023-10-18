import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_blood_bank/src/models/places_model.dart';

import '../../constants/const_methods.dart';
import '../../constants/end_points.dart';
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
        places = response.data!;
        emit(GetHospitalsSuccess());
      });
    } catch (e) {
      emit(GetHospitalsFailure());
    }
  }

  Future getBloodBanks() async {
    places.clear();
    try {
      emit(GetBloodBanksLoading());
      await DioHelper.getData(
        url: EndPoints.epGetHospitals,
      ).then((value) {
        logSuccess('getBloodBanks Response : ${value.data}');
        final response = PlacesModel.fromJson(value.data);
        places = response.data!;
        emit(GetBloodBanksSuccess());
      });
    } catch (e) {
      emit(GetBloodBanksFailure());
    }
  }
}
