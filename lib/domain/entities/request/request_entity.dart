import 'package:chattyevent_app_flutter/core/enums/request/request_type_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/request/invitation_data_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/request/join_request_data_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';

class RequestEntity {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final RequestTypeEnum type;
  final InvitationDataEntity? invitationData;
  final JoinRequestDataEntity? joinRequestData;
  final UserEntity createdBy;

  RequestEntity({
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.id,
    required this.type,
    this.invitationData,
    this.joinRequestData,
  });
}
