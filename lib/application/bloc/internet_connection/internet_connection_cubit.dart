import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/usecases/internet_connection_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'internet_connection_state.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  final InternetConnectionUseCases internetConnectionUseCases;
  final NotificationCubit notificationCubit;

  InternetConnectionCubit({
    required this.internetConnectionUseCases,
    required this.notificationCubit,
  }) : super(InternetConnectionState(hasInternet: true)) {
    executeListenStream();
  }

  executeListenStream() {
    final streamOrFail =
        internetConnectionUseCases.newInternetConnectionMessage();
    streamOrFail.fold(
      (alert) => null,
      (stream) {
        stream.listen((hasInternet) {
          emit(InternetConnectionState(hasInternet: hasInternet));
        });
      },
    );
  }
}
