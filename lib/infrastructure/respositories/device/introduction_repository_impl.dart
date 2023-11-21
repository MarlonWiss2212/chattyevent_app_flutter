import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/entities/introduction/introduction_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/introduction_repository.dart';
import 'package:chattyevent_app_flutter/infrastructure/datasources/local/persist_hive_datasource.dart';
import 'package:dartz/dartz.dart';

class IntroductionRepositoryImpl extends IntroductionRepository {
  final PersistHiveDatasource persistHiveDatasource;
  IntroductionRepositoryImpl({
    required this.persistHiveDatasource,
  });

  @override
  Future<void> saveIntroductionInStorage({
    required IntroductionEntity introduction,
  }) async {
    return await persistHiveDatasource.put<IntroductionEntity>(
      key: "introduction",
      value: introduction,
    );
  }

  @override
  Either<NotificationAlert, IntroductionEntity> getIntroductionFromStorage() {
    try {
      final IntroductionEntity response =
          persistHiveDatasource.get<IntroductionEntity>(
        key: "introduction",
      );
      return Right(response);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
