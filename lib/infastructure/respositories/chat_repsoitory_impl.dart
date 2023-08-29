import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/entities/chat_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/chat_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:chattyevent_app_flutter/infastructure/models/chat_model.dart';
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
              _id
              profileImageLink
              title
              latestMessage {
                _id
                message
                readBy
                messageToReactTo {
                  _id
                  readBy
                  message
                  fileLinks
                  groupchatTo
                  createdBy
                  updatedAt
                  createdAt
                }
                fileLinks
                updatedAt
                groupchatTo
                createdBy
                createdAt
              }
            }
            event {
              _id
              status
              title
              type
              privateEventData {
                groupchatTo
              }
              eventDate
              eventEndDate
              eventLocation {
                geoJson {
                  type
                  coordinates
                }
              }
              coverImageLink
              latestMessage {
                _id
                readBy
                message
                messageToReactTo {
                  _id
                  readBy
                  message
                  fileLinks
                  eventTo
                  updatedAt
                  createdBy
                  createdAt
                }
                fileLinks
                eventTo
                updatedAt
                createdBy
                createdAt
              }
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
                messageToReactTo {
                  _id
                  readBy
                  message
                  fileLinks
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
