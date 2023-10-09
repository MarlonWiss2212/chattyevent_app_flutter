import 'dart:convert';

import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/hive_utils.dart';
import 'package:chattyevent_app_flutter/domain/repositories/secure_storage_repository.dart';
import 'package:dartz/dartz.dart';

class SecureStorageUseCases {
  final SecureStorageRepository secureStorageRepository;
  SecureStorageUseCases({
    required this.secureStorageRepository,
  });

  Future<Either<NotificationAlert, String>> getSecureKeyOrGenerateNew(
      {required String key}) async {
    final valueOrFailure = await secureStorageRepository.read(key: key);
    return await valueOrFailure.fold(
      (alert) async {
        final secureKey = HiveUtils.generateSecureKey();
        final generatedKey = await secureStorageRepository.write(
          key: key,
          value: base64Encode(secureKey),
        );

        return await generatedKey.fold((alert) => Left(alert), (_) async {
          return await secureStorageRepository.read(
            key: key,
          );
        });
      },
      (value) => Right(value),
    );
  }
}
