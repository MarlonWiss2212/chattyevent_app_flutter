import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';
import 'package:meta/meta.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  newAlert({required NotificationAlert notificationAlert}) {
    emit(notificationAlert);
  }
}
