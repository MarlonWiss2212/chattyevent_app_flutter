import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/chat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/request/request_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/request_usecases.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/request/find_one_request_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/request/find_requests_filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'requests_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  final RequestUseCases requestUseCases;
  final NotificationCubit notificationCubit;
  final ChatCubit chatCubit;

  RequestsCubit({
    required this.requestUseCases,
    required this.notificationCubit,
    required this.chatCubit,
  }) : super(RequestsState(requests: [], loading: false));

  Future<void> getRequestsViaApi({bool reload = false}) async {
    emit(RequestsState(requests: state.requests, loading: true));

    final requestsOrFailure = await requestUseCases.getRequestsViaApi(
      findRequestsFilter: FindRequestsFilter(),
      limitOffsetFilter: reload
          ? LimitOffsetFilter(
              limit: state.requests.length < 10 ? 10 : state.requests.length,
              offset: 0,
            )
          : LimitOffsetFilter(
              limit: 10,
              offset: state.requests.length,
            ),
    );
    requestsOrFailure.fold(
      (alert) {
        emit(RequestsState(requests: state.requests, loading: false));
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (requests) {
        if (reload) {
          emit(RequestsState(requests: requests, loading: false));
        } else {
          emit(RequestsState(
            requests: [...state.requests, ...requests],
            loading: false,
          ));
        }
      },
    );
  }

  Future<void> acceptInvitationViaApiAndReloadRequests({
    required RequestEntity invitation,
  }) async {
    if (invitation.invitationData == null) {
      notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Fehler",
          message: "Fehler beim Annehmen der Einladung",
        ),
      );
      return;
    }
    final acceptedOrFailure = await requestUseCases.acceptRequestViaApi(
      findOneRequestFilter: FindOneRequestFilter(id: invitation.id),
    );
    await acceptedOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (_) async {
        if (invitation.invitationData!.groupchatUser != null) {
          chatCubit.replaceOrAdd(
            chat: ChatEntity(
              groupchat: invitation.invitationData!.groupchatUser!.groupchat,
            ),
          );
        }
        if (invitation.invitationData!.eventUser != null &&
            invitation.invitationData!.eventUser!.event.privateEventData
                    ?.groupchatTo ==
                null) {
          chatCubit.replaceOrAdd(
            chat: ChatEntity(
              event: invitation.invitationData!.eventUser!.event,
            ),
          );
        }
        emit(RequestsState(
          loading: state.loading,
          requests: state.requests
              .where((element) => element.id != invitation.id)
              .toList(),
        ));
        await getRequestsViaApi(reload: true);
      },
    );
  }

  Future<void> deleteRequestViaApiAndReloadRequests({
    required RequestEntity request,
  }) async {
    final deletedOrFailure = await requestUseCases.deleteRequestViaApi(
      findOneRequestFilter: FindOneRequestFilter(id: request.id),
    );

    await deletedOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (_) async {
        emit(RequestsState(
          loading: state.loading,
          requests: state.requests
              .where((element) => element.id != request.id)
              .toList(),
        ));
        await getRequestsViaApi(reload: true);
      },
    );
  }

  @override
  void emit(RequestsState state) {
    RequestsState newState = state;
    newState.requests.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    super.emit(newState);
  }
}
