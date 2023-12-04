import 'package:chattyevent_app_flutter/domain/entities/imprint/imprint_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

/// Repository for handling imprint-related functionality.
abstract class ImprintRepository {
  /// Retrieves imprint via API.
  /// Returns a [NotificationAlert] in case of an error or an [ImprintEntity] when successful.
  Future<Either<NotificationAlert, ImprintEntity>> getImprintViaApi();
}
