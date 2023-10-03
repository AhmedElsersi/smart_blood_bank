part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class VerifyPhoneLoading extends AuthState {}

class VerifyPhoneSuccess extends AuthState {}

class VerifyPhoneFail extends AuthState {}

class SendOtpLoading extends AuthState {}

class SendOtpSuccess extends AuthState {}

class SendOtpFail extends AuthState {}

class VerifyOTPLoading extends AuthState {}

class VerifyOTPSuccess extends AuthState {}

class VerifyOTPFail extends AuthState {}

class GetIndustriesLoading extends AuthState {}

class GetIndustriesSuccess extends AuthState {}

class GetIndustriesFailure extends AuthState {}

class GetInterestsLoading extends AuthState {}

class GetInterestsSuccess extends AuthState {}

class GetInterestsFailure extends AuthState {}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterFailure extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {}

class LogoutLoading extends AuthState {}

class LogoutSuccess extends AuthState {}

class LogoutFailure extends AuthState {}

class RefreshTokenLoading extends AuthState {}

class RefreshTokenSuccess extends AuthState {}

class RefreshTokenFailure extends AuthState {}

class GetProfileLoading extends AuthState {}

class GetProfileSuccess extends AuthState {}

class GetProfileFailure extends AuthState {}
