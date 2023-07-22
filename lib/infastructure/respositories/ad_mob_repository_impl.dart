import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/repositories/ad_mob_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/remote/ad_mob.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_funding_choices/flutter_funding_choices.dart';

class AdMobRepositoryImpl implements AdMobRepository {
  final AdMobDatasource adMobDatasource;
  AdMobRepositoryImpl({required this.adMobDatasource});

  @override
  Future<Either<NotificationAlert, Unit>> showAdMobPopUpIfRequired() async {
    try {
      final consentInfo = await adMobDatasource.requestConsentInformation();
      final isConsentFormAvailable = adMobDatasource.isConsentFormAvailable(
        consentInformation: consentInfo,
      );
      final consentStatusIsRequired = adMobDatasource.consentStatus(
            consentInformation: consentInfo,
          ) ==
          ConsentStatus.required;
      if (isConsentFormAvailable && consentStatusIsRequired) {
        await adMobDatasource.showConsentForm();
        return const Right(unit);
      }
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
