import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const supportedLocales = AppLocalizations.supportedLocales;

const localizationDelegates = AppLocalizations.localizationsDelegates;

extension AppStrings on BuildContext {
  bool get isAr => AppLocalizations.of(this)!.localeName == "ar";

  String get smart_blood_bank => AppLocalizations.of(this)!.smart_blood_bank;
  String get startNow => AppLocalizations.of(this)!.startNow;
  String get skip => AppLocalizations.of(this)!.skip;
  String get omBoardingTitle1 => AppLocalizations.of(this)!.omBoardingTitle1;
  String get omBoardingSubTitle1 =>
      AppLocalizations.of(this)!.omBoardingSubTitle1;
  String get omBoardingTitle2 => AppLocalizations.of(this)!.omBoardingTitle2;
  String get omBoardingSubTitle2 =>
      AppLocalizations.of(this)!.omBoardingSubTitle2;
  String get omBoardingTitle3 => AppLocalizations.of(this)!.omBoardingTitle3;
  String get omBoardingSubTitle3 =>
      AppLocalizations.of(this)!.omBoardingSubTitle3;
}
