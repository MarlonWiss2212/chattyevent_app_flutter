import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// Repository for handling URL launching functionality.
abstract class LaunchUrlRepository {
  /// Checks if the device can launch the provided [url].
  /// Returns a [NotificationAlert] in case of an error or a boolean indicating if the URL can be launched.
  Future<Either<NotificationAlert, bool>> canLaunchUrl({required String url});

  /// Launches the provided [url] using the [launchMode].
  /// Returns a [NotificationAlert] in case of an error or a boolean indicating if the URL was successfully launched.
  Future<Either<NotificationAlert, bool>> launchUrl({
    required String url,
    LaunchMode launchMode = LaunchMode.platformDefault,
  });
}
