import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserUseCases userUseCases;

  UserProfileBloc({required this.userUseCases}) : super(UserProfileInitial()) {
    on<UserProfileEvent>((event, emit) {});

    on<UserProfileRequestEvent>((event, emit) async {
      emit(UserProfileStateLoading());

      final Either<Failure, UserEntity> userProfileOrFailure =
          await userUseCases.getUserProfileUseCase(
        userId: event.userId,
        email: event.email,
      );

      userProfileOrFailure.fold(
        (error) => emit(
          UserProfileStateError(message: mapFailureToMessage(error)),
        ),
        (userProfile) => emit(UserProfileStateLoaded(userProfile: userProfile)),
      );
    });
  }
}
