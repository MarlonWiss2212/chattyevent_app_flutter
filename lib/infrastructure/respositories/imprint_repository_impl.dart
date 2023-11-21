import 'dart:convert';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/entities/imprint/imprint_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/imprint_repository.dart';
import 'package:chattyevent_app_flutter/infrastructure/datasources/remote/http.dart';
import 'package:chattyevent_app_flutter/infrastructure/models/imprint/imprint_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ImprintRepositoryImpl implements ImprintRepository {
  final HttpDatasource httpDatasource;

  ImprintRepositoryImpl({required this.httpDatasource});

  @override
  Future<Either<NotificationAlert, ImprintEntity>> getImprintViaApi() async {
    try {
      final response = await httpDatasource.get(
        url: "${dotenv.get("API_BASE_URL")}/imprint",
      );
      final json = jsonDecode(response.body);

      return Right(ImprintModel.fromJson(json));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
