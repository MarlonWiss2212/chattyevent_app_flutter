import 'package:bloc/bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/imprint/imprint_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/imprint_usecases.dart';
import 'package:meta/meta.dart';

part 'imprint_state.dart';

class ImprintCubit extends Cubit<ImprintState> {
  final ImprintUseCases imprintUseCases;
  final NotificationCubit notificationCubit;

  ImprintCubit({
    required this.imprintUseCases,
    required this.notificationCubit,
  }) : super(ImprintState());

  getImprintViaApi() async {
    emit(ImprintState(imprint: state.imprint, imprintLoading: true));
    final imprintOrAlert = await imprintUseCases.getImprintViaApi();

    imprintOrAlert.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emit(ImprintState(imprint: state.imprint, imprintLoading: false));
      },
      (imprint) {
        emit(ImprintState(imprint: imprint));
      },
    );
  }
}
