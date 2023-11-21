import 'dart:async';

import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/enums/message/message_stream_type_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/message_usecases.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/message/added_message_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/message/updated_message_filter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'message_stream_state.dart';

class MessageStreamCubit extends Cubit<MessageStreamState> {
  final MessageUseCases messageUseCases;
  final NotificationCubit notificationCubit;
  StreamSubscription<Either<NotificationAlert, MessageEntity>>? _subscription;
  StreamSubscription<Either<NotificationAlert, MessageEntity>>?
      _updateSubscription;

  MessageStreamCubit({
    required this.messageUseCases,
    required this.notificationCubit,
  }) : super(MessageStreamState()) {
    final eitherAlertOrStream = messageUseCases.getMessagesRealtimeViaApi(
      addedMessageFilter: AddedMessageFilter(
        returnMyAddedMessageToo: false,
      ),
    );
    final eitherAlertOrUpdatedStream =
        messageUseCases.getUpdatedMessagesRealtimeViaApi(
      updatedMessageFilter: UpdatedMessageFilter(),
    );

    eitherAlertOrStream.then(
      (value) => value.fold(
        (alert) => notificationCubit.newAlert(
          notificationAlert: alert,
        ),
        (subscription) {
          _subscription = subscription.listen(
            (event) {
              event.fold(
                (error) => notificationCubit.newAlert(notificationAlert: error),
                (message) => emit(MessageStreamState(
                  message: message,
                  streamType: MessageStreamTypeEnum.added,
                )),
              );
            },
          );
        },
      ),
    );
    eitherAlertOrUpdatedStream.then(
      (value) => value.fold(
        (alert) => notificationCubit.newAlert(
          notificationAlert: alert,
        ),
        (subscription) {
          _updateSubscription = subscription.listen(
            (event) {
              print(event);
              event.fold(
                (error) => notificationCubit.newAlert(notificationAlert: error),
                (message) => emit(MessageStreamState(
                  message: message,
                  streamType: MessageStreamTypeEnum.updated,
                )),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _updateSubscription?.cancel();
    _subscription = null;
    _updateSubscription = null;

    return super.close();
  }
}
