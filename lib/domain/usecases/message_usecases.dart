import 'dart:async';
import 'package:chattyevent_app_flutter/core/enums/message/message_type_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_to_react_to_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/message_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/message/find_one_message_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/message/updated_message_filter.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/message/create_message_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/message/added_message_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/message/find_messages_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';
import 'package:easy_localization/easy_localization.dart';

class MessageUseCases {
  final MessageRepository messageRepository;
  MessageUseCases({required this.messageRepository});

  String translateCustomMessage({
    required Either<MessageEntity, MessageToReactToEntity> message,
    required bool isGroupchatMessage,
    required List<UserEntity> users,
    UserEntity? createdBy,
    String? affectedId,
  }) {
    final UserEntity? affectedUser = affectedId != null
        ? users.firstWhereOrNull(
            (element) => element.id == affectedId,
          )
        : null;

    final MessageTypeEnum? type = message.fold((m) => m.type, (m) => m.type);
    final String typeText =
        isGroupchatMessage ? "general.chatText".tr() : "general.eventText".tr();
    if (type != null) {
      switch (type) {
        case MessageTypeEnum.defaultMessage:
          break;
        case MessageTypeEnum.userJoined:
          return "general.chatMessage.notificationContainer.userJoinedText".tr(
            namedArgs: {
              "username": createdBy?.username ?? "",
              "type": typeText,
            },
          );
        case MessageTypeEnum.userJoinedByInvitation:
          return "general.chatMessage.notificationContainer.userJoinedByInvitationText"
              .tr(
            namedArgs: {
              "createdByUsername": createdBy?.username ?? "",
              "affectedUsername": affectedUser?.username ?? "",
              "type": typeText,
            },
          );
        case MessageTypeEnum.userLeft:
          return "general.chatMessage.notificationContainer.userLeftText".tr(
            namedArgs: {
              "username": createdBy?.username ?? "",
              "type": typeText,
            },
          );
        case MessageTypeEnum.userAddedBy:
          return "general.chatMessage.notificationContainer.userAddedByText".tr(
            namedArgs: {
              "createdByUsername": createdBy?.username ?? "",
              "affectedUsername": affectedUser?.username ?? "",
              "type": typeText,
            },
          );
        case MessageTypeEnum.userKickedBy:
          return "general.chatMessage.notificationContainer.userKickedByText"
              .tr(
            namedArgs: {
              "createdByUsername": createdBy?.username ?? "",
              "affectedUsername": affectedUser?.username ?? "",
              "type": typeText,
            },
          );
      }
    }
    return "general.errorText".tr();
  }

  Future<Either<NotificationAlert, MessageEntity>> createMessageViaApi({
    required CreateMessageDto createMessageDto,
  }) async {
    return messageRepository.createMessageViaApi(
      createMessageDto: createMessageDto,
    );
  }

  Future<Either<NotificationAlert, List<MessageEntity>>> getMessagesViaApi({
    required FindMessagesFilter findMessagesFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    return messageRepository.getMessagesViaApi(
      findMessagesFilter: findMessagesFilter,
      limitOffsetFilter: limitOffsetFilter,
    );
  }

  Future<
          Either<NotificationAlert,
              Stream<Either<NotificationAlert, MessageEntity>>>>
      getMessagesRealtimeViaApi({
    required AddedMessageFilter addedMessageFilter,
  }) {
    return messageRepository.getMessagesRealtimeViaApi(
      addedMessageFilter: addedMessageFilter,
    );
  }

  Future<
          Either<NotificationAlert,
              Stream<Either<NotificationAlert, MessageEntity>>>>
      getUpdatedMessagesRealtimeViaApi({
    required UpdatedMessageFilter updatedMessageFilter,
  }) {
    return messageRepository.getUpdatedMessagesRealtimeViaApi(
      updatedMessageFilter: updatedMessageFilter,
    );
  }

  Future<Either<NotificationAlert, MessageEntity>> deleteMessageViaApi({
    required FindOneMessage filter,
  }) async {
    return await messageRepository.deleteMessageViaApi(filter: filter);
  }
}
