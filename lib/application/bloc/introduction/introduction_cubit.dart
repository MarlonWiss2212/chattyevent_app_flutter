import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/introduction/introduction_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/introduction_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'introduction_state.dart';

class IntroductionCubit extends Cubit<IntroductionState> {
  final IntroductionUseCases introductionUseCases;
  final NotificationCubit notificationCubit;
  IntroductionCubit({
    required this.introductionUseCases,
    required this.notificationCubit,
  }) : super(IntroductionState());

  Future<void> saveToStorage({required IntroductionEntity introduction}) async {
    await introductionUseCases.saveIntroductionInStorage(
      introduction: introduction,
    );
    emit(IntroductionState(introduction: introduction));
  }

  Future<void> getFromStorage({
    required IntroductionEntity introduction,
  }) async {
    final response = await introductionUseCases.getIntroductionFromStorage();
    response.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (value) => emit(IntroductionState(introduction: introduction)),
    );
  }
}
