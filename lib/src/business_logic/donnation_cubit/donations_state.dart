part of 'donations_cubit.dart';

@immutable
abstract class DonationsState {}

class DonationsInitial extends DonationsState {}

class DonateLoading extends DonationsState {}

class DonateSuccess extends DonationsState {}

class DonateFailure extends DonationsState {}

class GetDonationsLoading extends DonationsState {}

class GetDonationsSuccess extends DonationsState {}

class GetDonationsFailure extends DonationsState {}

class GetDonationLoading extends DonationsState {}

class GetDonationSuccess extends DonationsState {}

class GetDonationFailure extends DonationsState {}

class AskDonationLoading extends DonationsState {}

class AskDonationSuccess extends DonationsState {}

class AskDonationFailure extends DonationsState {}

class GetAskDonationsLoading extends DonationsState {}

class GetAskDonationsSuccess extends DonationsState {}

class GetAskDonationsFailure extends DonationsState {}

class GetAskDonationLoading extends DonationsState {}

class GetAskDonationSuccess extends DonationsState {}

class GetAskDonationFailure extends DonationsState {}

class AcceptRefuseDonationLoading extends DonationsState {}

class AcceptRefuseDonationSuccess extends DonationsState {}

class AcceptRefuseDonationFailure extends DonationsState {}

class AcceptRefuseAskDonationLoading extends DonationsState {}

class AcceptRefuseAskDonationSuccess extends DonationsState {}

class AcceptRefuseAskDonationFailure extends DonationsState {}
