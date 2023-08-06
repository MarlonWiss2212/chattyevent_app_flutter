import 'package:chattyevent_app_flutter/domain/repositories/launch_url_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LaunchUrlUseCases {
  final LaunchUrlRepository launchUrlRepository;
  LaunchUrlUseCases({
    required this.launchUrlRepository,
  });

  Future<Either<NotificationAlert, Unit>> launchUrl({
    required String url,
    LaunchMode launchMode = LaunchMode.platformDefault,
  }) async {
    final canLaunchUrlOrFailure = await launchUrlRepository.canLaunchUrl(
      url: url,
    );
    return canLaunchUrlOrFailure.fold(
      (alert) => Left(alert),
      (canLaunchUrl) async {
        if (canLaunchUrl == false) {
          return Left(NotificationAlert(
            message: "Konnte folgende url nicht öffnen: $url",
            title: "Url öffnen Fehler",
          ));
        }

        final workedOrFailure = await launchUrlRepository.launchUrl(
            url: url, launchMode: launchMode);

        return workedOrFailure.fold(
          (alert) => Left(alert),
          (worked) {
            if (worked) {
              return const Right(unit);
            }
            return Left(NotificationAlert(
              message: "Konnte folgende url nicht öffnen: $url",
              title: "Url öffnen Fehler",
            ));
          },
        );
      },
    );
  }
}
