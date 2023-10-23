import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/entities/chat_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/chat_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:chattyevent_app_flutter/infastructure/models/chat_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/event/event_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/groupchat/groupchat_model.dart';
import 'package:dartz/dartz.dart';

class ChatRepositoryImpl implements ChatRepository {
  final GraphQlDatasource graphQlDatasource;
  ChatRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<NotificationAlert, List<ChatEntity>>> getChatsViaApi() async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindChats {
          findChats {
            groupchat {
              ${GroupchatModel.groupchatLightQuery(alsoLatestMessage: true)}
            }
            event {
              ${EventModel.eventLightQuery(alsoLatestMessage: true)}
            } 
            user {
              _id
              authId
              username
              profileImageLink
              myUserRelationToOtherUser {
                _id
                createdAt
                updatedAt
                status
                followData {
                  followedUserAt
                }
              }
              otherUserRelationToMyUser {
                _id
                createdAt
                updatedAt
                status
                followData {
                  followedUserAt
                }
              }
              latestMessage {
                _id
                readBy
                message
                type
                typeActionAffectedUserId
                messageToReactTo {
                  _id
                  readBy
                  message
                  fileLinks
                  type
                  typeActionAffectedUserId
                  userTo
                  updatedAt
                  createdBy
                  createdAt
                }
                fileLinks
                userTo
                updatedAt
                createdBy
                createdAt
              }
            }
          }
        }
        """,
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden Chats Fehler",
          response: response,
        ));
      }

      final List<ChatEntity> chats = [];
      for (final chat in response.data!["findChats"]) {
        chats.add(ChatModel.fromJson(chat));
      }
      return Right(chats);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
