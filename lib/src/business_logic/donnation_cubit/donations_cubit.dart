import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_blood_bank/src/models/donation_model.dart';
import 'package:smart_blood_bank/src/models/request_donation_model.dart';

import '../../constants/const_methods.dart';
import '../../constants/end_points.dart';
import '../../models/ask_donation_model_response.dart';
import '../../models/ask_donations_model_response.dart';
import '../../models/donation_model_response.dart';
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
      {int? recipientId,
      int? hospitalId,
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

  List<Donation> donations = [];
  Future getDonations() async {
    try {
      emit(GetDonationsLoading());
      await DioHelper.getData(
        url: EndPoints.epGetDonations,
      ).then((value) {
        logSuccess('getDonations Response : ${value.data}');
        final hh = DonationsModel.fromJson(value.data);
        donations = hh.data ?? [];
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

  List<AskDonation> askDonations = [];
  Future getAskDonations({required String type}) async {
    try {
      logWarning(type);
      emit(GetAskDonationsLoading());
      await DioHelper.getData(
        url: EndPoints.epGetAskDonations,
        query: {
          "type": type,
        },
      ).then((value) {
        logSuccess('getAskDonations Response : ${value.data}');
        final hh = AskDonationsModel.fromJson(value.data);
        askDonations = hh.data ?? [];
        emit(GetAskDonationsSuccess());
      });
    } on DioException catch (dioError) {
      logError('getAskDonations error ${dioError.response}');
    } catch (e) {
      emit(GetAskDonationsFailure());
    }
  }

  AskDonationModel askDonationResponse = AskDonationModel();
  Future getAskDonationById({required int id}) async {
    try {
      emit(GetAskDonationLoading());
      await DioHelper.getData(
        url: EndPoints.epGetAskDonation,
        query: {
          "id": id,
        },
      ).then((value) {
        logSuccess('getAskDonationById Response : ${value.data}');
        askDonationResponse = AskDonationModel.fromJson(value.data);
        logSuccess('getAskDonationById Response : ${askDonationResponse}');

        emit(GetAskDonationSuccess());
      });
    } on DioException catch (dioError) {
      logError('getAskDonationById error ${dioError.response}');
    } catch (e) {
      logError('getAskDonationById error ${e}');
      emit(GetAskDonationFailure());
    }
  }

  Future acceptRefuseDonation(
      {required int id, required String status, String? reason}) async {
    try {
      emit(AcceptRefuseDonationLoading());
      await DioHelper.getData(
        url: EndPoints.epAcceptRefuseDonation,
        query: {
          "donation_id": id,
          "status": status,
          if (status != 'accept') "cancel_reason": reason,
        },
      ).then((value) {
        logSuccess('getAskDonationById Response : ${value.data}');
        emit(AcceptRefuseDonationSuccess());
      });
    } on DioException catch (dioError) {
      logError('getAskDonationById error ${dioError.response}');
    } catch (e) {
      emit(AcceptRefuseDonationFailure());
    }
  }

  Future acceptRefuseAskDonation(
      {required int id, required String status, String? reason}) async {
    try {
      emit(AcceptRefuseAskDonationLoading());
      await DioHelper.getData(
        url: EndPoints.epAcceptRefuseAskDonation,
        query: {
          "donation_id": id,
          "status": status,
          if (status != 'accept') "cancel_reason": reason,
        },
      ).then((value) {
        logSuccess('acceptRefuseAskDonation Response : ${value.data}');
        emit(AcceptRefuseAskDonationSuccess());
      });
    } on DioException catch (dioError) {
      logError('acceptRefuseAskDonation error ${dioError.response}');
    } catch (e) {
      emit(AcceptRefuseAskDonationFailure());
    }
  }
}
