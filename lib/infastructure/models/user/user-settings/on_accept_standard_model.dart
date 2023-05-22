import 'package:chattyevent_app_flutter/domain/entities/user/user-settings/on_accept_standard_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user/user-settings/on_accept_standard/follow_data_model.dart';

class OnAcceptStandardModel extends OnAcceptStandardEntity {
  OnAcceptStandardModel({super.followData});

  factory OnAcceptStandardModel.fromJson(Map<String, dynamic> json) {
    return OnAcceptStandardModel(
      followData: json['followData'] != null
          ? OnAcceptStandardFollowDataModel.fromJson(
              json['followData'],
            )
          : null,
    );
  }
}
