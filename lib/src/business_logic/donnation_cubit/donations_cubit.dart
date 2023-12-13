import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_blood_bank/src/models/donation_model.dart';
import 'package:smart_blood_bank/src/models/request_donation_model.dart';

import '../../constants/const_methods.dart';
import '../../constants/end_points.dart';
import '../../services/dio_helper.dart';

part 'donations_state.dart';

class DonationsCubit extends Cubit<DonationsState> {
  DonationsCubit() : super(DonationsInitial());
  static DonationsCubit get(BuildContext context) => BlocProvider.of(context);

  DonationModel donationModel = DonationModel();
  Future donate(
      {required int donorId,
      required int bloodBankId,
      required String donationDay,
      required String donationTime}) async {
    emit(DonateLoading());
    try {
      await DioHelper.postData(
        url: EndPoints.epDonate,
        body: {
          "donor_id": donorId,
          "bloodbankId": bloodBankId,
          "donnationDay": donationDay,
          "donnationTime": donationTime,
        },
      ).then((value) {
        logSuccess('donate Response : ${value.data}');
        donationModel = DonationModel.fromJson(value.data);
        emit(DonateSuccess());
      });
    } on DioError catch (dioError) {
      logError('mmmm ${dioError.response}');
      emit(DonateFailure());
    } catch (error) {
      logError(error.toString());
      emit(DonateFailure());
    }
  }

  RequestDonationModel requestDonationModel = RequestDonationModel();
  Future askDonation(
      {required int recipientId,
      required int hospitalId,
      required int bloodBankId,
      required String bloodType,
      required double quantity,
      required String donationDay,
      required String donationTime}) async {
    emit(AskDonationLoading());
    try {
      await DioHelper.postData(
        url: EndPoints.epRequestDonation,
        body: {
          "recipient_id": recipientId,
          "hospital_id": hospitalId,
          "blood_bank_id": bloodBankId,
          "requested_blood_type": bloodType,
          "quantity": quantity,
          "donation_date": donationDay,
          "donation_time": donationTime,
        },
      ).then((value) {
        logSuccess('askDonation Response : ${value.data}');
        requestDonationModel = RequestDonationModel.fromJson(value.data);
        emit(AskDonationSuccess());
      });
    } on DioError catch (dioError) {
      logError('mmmm ${dioError.response}');
      emit(AskDonationFailure());
    } catch (error) {
      logError(error.toString());
      emit(AskDonationFailure());
    }
  }

  List<dynamic> donations = [];
  Future getDonations() async {
    try {
      emit(GetDonationsLoading());
      await DioHelper.getData(
        url: EndPoints.epGetDonations,
      ).then((value) {
        logSuccess('getDonations Response : ${value.data}');
        emit(GetDonationsSuccess());
      });
    } on DioException catch (dioError) {
      logError('getDonations error ${dioError.response}');
    } catch (e) {
      emit(GetDonationsFailure());
    }
  }

  dynamic donation;
  Future getDonationById({required int id}) async {
    try {
      emit(GetDonationLoading());
      await DioHelper.getData(
        url: EndPoints.epGetDonation(id),
      ).then((value) {
        logSuccess('getDonationById Response : ${value.data}');
        emit(GetDonationSuccess());
      });
    } on DioException catch (dioError) {
      logError('getDonationById error ${dioError.response}');
    } catch (e) {
      emit(GetDonationFailure());
    }
  }

  List<dynamic> askDonations = [];
  Future getAskDonations() async {
    try {
      emit(GetAskDonationsLoading());
      await DioHelper.getData(
        url: EndPoints.epGetAskDonations,
      ).then((value) {
        logSuccess('getAskDonations Response : ${value.data}');
        emit(GetAskDonationsSuccess());
      });
    } on DioException catch (dioError) {
      logError('getAskDonations error ${dioError.response}');
    } catch (e) {
      emit(GetAskDonationsFailure());
    }
  }

  dynamic askDonationResponse;
  Future getAskDonationById({required int id}) async {
    try {
      emit(GetAskDonationLoading());
      await DioHelper.getData(
        url: EndPoints.epGetAskDonation(id),
      ).then((value) {
        logSuccess('getAskDonationById Response : ${value.data}');
        emit(GetAskDonationSuccess());
      });
    } on DioException catch (dioError) {
      logError('getAskDonationById error ${dioError.response}');
    } catch (e) {
      emit(GetAskDonationFailure());
    }
  }
}
