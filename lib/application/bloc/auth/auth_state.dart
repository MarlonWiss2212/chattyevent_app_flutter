import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state_status.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/auth_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/one_signal_use_cases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/permission_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/user_usecases.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/user/find_one_user_filter.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';
import 'package:hive/hive.dart';

part 'auth_state.g.dart';
part 'auth_cubit.dart';

@HiveType(typeId: 4)
class AuthState {
  @HiveField(0)
  final AuthStateStatus status;

  @HiveField(1)
  final String? token;

  @HiveField(2)
  final UserEntity currentUser;

  @HiveField(3)
  final bool dataprotectionCheckbox;

  @HiveField(4)
  final bool sendedResetPasswordEmail;
  @HiveField(5)
  final bool sendedVerificationEmail;

  @HiveField(6)
  final OperationException? userException;

  factory AuthState.standardState(User? user) {
    return AuthState(
      currentUser: UserEntity(
        authId: user?.uid ?? "",
        id: "",
      ),
      token: "",
      status: AuthStateStatus.initial,
    );
  }

  AuthState({
    required this.currentUser,
    this.dataprotectionCheckbox = false,
    this.token,
    this.status = AuthStateStatus.initial,
    this.sendedResetPasswordEmail = false,
    this.sendedVerificationEmail = false,
    this.userException,
  });
}
