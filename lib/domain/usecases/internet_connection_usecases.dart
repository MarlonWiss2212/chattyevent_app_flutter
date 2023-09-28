import 'dart:async';

import 'package:chattyevent_app_flutter/domain/repositories/device/internet_connection_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

class InternetConnectionUseCases {
  final InternetConnectionRepository internetConnectionRepository;
  InternetConnectionUseCases({required this.internetConnectionRepository});

  Either<NotificationAlert, Stream<bool>> newInternetConnectionMessage() {
    final failOrStream =
        internetConnectionRepository.internetConnectionStream();

    connectivityToBoolStream({
      required Stream<ConnectivityResult> stream,
    }) async* {
      await for (final data in stream) {
        yield data != ConnectivityResult.none;
      }
    }

    return failOrStream.fold(
      (alert) => Left(alert),
      (stream) => Right(connectivityToBoolStream(stream: stream)),
    );
  }
}
