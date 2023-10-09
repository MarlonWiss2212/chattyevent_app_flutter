import 'dart:convert';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/entities/introduction/introduction_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/introduction_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/local/persist_hive_datasource.dart';
import 'package:chattyevent_app_flutter/infastructure/models/introduction/introduction_model.dart';
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
    return await persistHiveDatasource.put<String>(
      key: "introduction",
      value: json.encode(introduction.toJson()),
    );
  }

  @override
  Either<NotificationAlert, IntroductionEntity> getIntroductionFromStorage() {
    try {
      final String response = persistHiveDatasource.get<String>(
        key: "introduction",
      );
      final Map<String, dynamic> convertedJson = json.decode(response);
      return Right(IntroductionModel.fromJson(convertedJson));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
