import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/introduction/introduction_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/introduction_usecases.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'introduction_state.dart';

class IntroductionCubit extends Cubit<IntroductionState> {
  final IntroductionUseCases introductionUseCases;
  final NotificationCubit notificationCubit;
  IntroductionCubit({
    required this.introductionUseCases,
    required this.notificationCubit,
  }) : super(IntroductionState());

  Future<void> saveToStorageAndNavigate(
    BuildContext context, {
    required IntroductionEntity introduction,
  }) async {
    await introductionUseCases.saveIntroductionInStorage(
      introduction: introduction,
    );
    emit(IntroductionState(introduction: introduction));
    // ignore: use_build_context_synchronously
    checkIfPageIsAvailableIfYesReplaceElsePop(context);
  }

  Future<void> getFromStorageOrCreateIfNullAndNavigate(
      BuildContext context) async {
    final response =
        await introductionUseCases.getIntroductionFromStorageIfNullCreateNew();
    response.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (value) {
        emit(IntroductionState(introduction: value));
        final permissions = value.appPermissionIntroduction;
        final features = value.appFeatureIntroduction;
        if (permissions.finishedNotificationPage == false) {
          context.pushRoute(
            const AppPermissionIntroductionRoutesNotificationRoute(),
          );
          return;
        } else if (permissions.finishedMicrophonePage == false) {
          context.pushRoute(
            const AppPermissionIntroductionRoutesMicrophoneRoute(),
          );
          return;
        } else if (features.finishedUsersPage == false) {
          context.pushRoute(const AppFeatureIntroductionRoutesUsersRoute());
          return;
        } else if (features.finishedMessagesPage == false) {
          context.pushRoute(const AppFeatureIntroductionRoutesMessageRoute());
          return;
        } else if (features.finishedPrivateEventPage == false) {
          context
              .pushRoute(const AppFeatureIntroductionRoutesPrivateEventRoute());
          return;
        } else if (features.finishedGroupchatsPage == false) {
          context.pushRoute(const AppFeatureIntroductionRoutesGroupchatRoute());
          return;
        }
      },
    );
  }

  void checkIfPageIsAvailableIfYesReplaceElsePop(BuildContext context) {
    if (state.introduction != null) {
      final permissions = state.introduction!.appPermissionIntroduction;
      final features = state.introduction!.appFeatureIntroduction;
      if (permissions.finishedNotificationPage == false) {
        context.replaceRoute(
          const AppPermissionIntroductionRoutesNotificationRoute(),
        );
        return;
      } else if (permissions.finishedMicrophonePage == false) {
        context.replaceRoute(
          const AppPermissionIntroductionRoutesMicrophoneRoute(),
        );
        return;
      } else if (features.finishedUsersPage == false) {
        context.replaceRoute(const AppFeatureIntroductionRoutesUsersRoute());
        return;
      } else if (features.finishedMessagesPage == false) {
        context.replaceRoute(const AppFeatureIntroductionRoutesMessageRoute());
        return;
      } else if (features.finishedPrivateEventPage == false) {
        context.replaceRoute(
          const AppFeatureIntroductionRoutesPrivateEventRoute(),
        );
        return;
      } else if (features.finishedGroupchatsPage == false) {
        context
            .replaceRoute(const AppFeatureIntroductionRoutesGroupchatRoute());
        return;
      }
    }
    context.popRoute();
  }
}
