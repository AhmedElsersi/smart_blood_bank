part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class VerifyPhoneLoading extends AuthState {}

class VerifyPhoneSuccess extends AuthState {}

class VerifyPhoneFailure extends AuthState {}

class VerifyPhoneVerifyErrorState extends AuthState {}

class VerifyingOtpLoadingState extends AuthState {}

class VerifyingOtpSuccessState extends AuthState {}

class VerifyingOtpFailureState extends AuthState {}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterFailure extends AuthState {}

class LogoutLoading extends AuthState {}

class LogoutSuccess extends AuthState {}

class LogoutFailure extends AuthState {}

class GetProfileLoading extends AuthState {}

class GetProfileSuccess extends AuthState {}

class GetProfileFailure extends AuthState {}
