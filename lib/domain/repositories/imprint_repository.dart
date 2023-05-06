import 'package:chattyevent_app_flutter/domain/entities/imprint/imprint_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

abstract class ImprintRepository {
  Future<Either<NotificationAlert, ImprintEntity>> getImprintViaApi();
}
