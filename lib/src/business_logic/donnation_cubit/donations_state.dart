part of 'donations_cubit.dart';

@immutable
abstract class DonationsState {}

class DonationsInitial extends DonationsState {}

class DonateLoading extends DonationsState {}

class DonateSuccess extends DonationsState {}

class DonateFailure extends DonationsState {}