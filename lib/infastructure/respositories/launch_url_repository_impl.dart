import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/repositories/launch_url_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LaunchUrlRepositoryImpl implements LaunchUrlRepository {
  @override
  Future<Either<NotificationAlert, bool>> canLaunchUrl({
    required String url,
  }) async {
    try {
      return Right(await canLaunchUrlString(url));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, bool>> launchUrl({
    required String url,
    LaunchMode launchMode = LaunchMode.platformDefault,
  }) async {
    try {
      return Right(await launchUrlString(url, mode: launchMode));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
