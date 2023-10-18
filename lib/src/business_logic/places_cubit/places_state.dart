part of 'places_cubit.dart';

@immutable
abstract class PlacesState {}

class PlacesInitial extends PlacesState {}

class GetHospitalsLoading extends PlacesState {}

class GetHospitalsSuccess extends PlacesState {}

class GetHospitalsFailure extends PlacesState {}

class GetHospitalLoading extends PlacesState {}

class GetHospitalSuccess extends PlacesState {}

class GetHospitalFailure extends PlacesState {}

class SearchHospitalsLoading extends PlacesState {}

class SearchHospitalsSuccess extends PlacesState {}

class SearchHospitalsFailure extends PlacesState {}

class GetBloodBanksLoading extends PlacesState {}

class GetBloodBanksSuccess extends PlacesState {}

class GetBloodBanksFailure extends PlacesState {}

class GetBloodBankLoading extends PlacesState {}

class GetBloodBankSuccess extends PlacesState {}

class GetBloodBankFailure extends PlacesState {}

class SearchBloodBanksLoading extends PlacesState {}

class SearchBloodBanksSuccess extends PlacesState {}

class SearchBloodBanksFailure extends PlacesState {}
