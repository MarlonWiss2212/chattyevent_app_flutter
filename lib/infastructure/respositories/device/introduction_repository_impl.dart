import 'dart:convert';

import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/entities/introduction/introduction_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/introduction_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/models/introduction/introduction_model.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/local/sharedPreferences.dart';

class IntroductionRepositoryImpl extends IntroductionRepository {
  final SharedPreferencesDatasource sharedPrefrencesDatasource;
  IntroductionRepositoryImpl({
    required this.sharedPrefrencesDatasource,
  });

  @override
  Future<void> saveIntroductionInStorage({
    required IntroductionEntity introduction,
  }) async {
    return await sharedPrefrencesDatasource.saveStringToStorage(
      "introduction",
      json.encode(introduction.toJson()),
    );
  }

  @override
  Future<Either<NotificationAlert, IntroductionEntity>>
      getIntroductionFromStorage() async {
    try {
      final response = await sharedPrefrencesDatasource.getStringFromStorage(
        "introduction",
      );
      return response.fold(
        (alert) => Left(alert),
        (value) {
          final Map<String, dynamic> convertedJson = json.decode(value);
          return Right(IntroductionModel.fromJson(convertedJson));
        },
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
