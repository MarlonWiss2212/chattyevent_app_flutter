import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:dartz/dartz.dart';

/// Repository for handling secure storage-related functionality.
abstract class SecureStorageRepository {
  /// Reads the value associated with the provided [key] from secure storage.
  /// Returns a [NotificationAlert] in case of an error or the stored value as a [String] when successful.
  Future<Either<NotificationAlert, String>> read({required String key});

  /// Writes the provided [value] associated with the provided [key] to secure storage.
  /// Returns a [NotificationAlert] in case of an error or [Unit] when successful.
  Future<Either<NotificationAlert, Unit>> write({
    required String key,
    required String? value,
  });
}
