import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:url_launcher/url_launcher_string.dart';

abstract class LaunchUrlRepository {
  Future<Either<NotificationAlert, bool>> canLaunchUrl({required String url});
  Future<Either<NotificationAlert, bool>> launchUrl({
    required String url,
    LaunchMode launchMode = LaunchMode.platformDefault,
  });
}
