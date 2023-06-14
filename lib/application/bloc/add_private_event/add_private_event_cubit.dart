import 'dart:io';
import 'package:chattyevent_app_flutter/core/filter/calendar/find_time_by_users_calendar_filter.dart';
import 'package:chattyevent_app_flutter/domain/usecases/calendar_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/private_event/create_location_private_event_dto.dart';
import 'package:chattyevent_app_flutter/core/dto/private_event/create_private_event_dto.dart';
import 'package:chattyevent_app_flutter/core/dto/private_event/private_event_user/create_private_event_user_from_private_event_dto.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/private_event_usecases.dart';
import 'package:chattyevent_app_flutter/domain/entities/calendar/calendar_time_user_entity.dart';
part 'add_private_event_state.dart';

class AddPrivateEventCubit extends Cubit<AddPrivateEventState> {
  final HomeEventCubit homeEventCubit;
  final PrivateEventUseCases privateEventUseCases;
  final NotificationCubit notificationCubit;
  final CalendarUseCases calendarUseCases;

  AddPrivateEventCubit({
    required this.privateEventUseCases,
    required this.homeEventCubit,
    required this.calendarUseCases,
    required this.notificationCubit,
  }) : super(AddPrivateEventState(
          isGroupchatEvent: false,
          calendarTimeUsers: [],
          privateEventUsersDto: [],
        ));

  Future createPrivateEventViaApi() async {
    if (state.coverImage == null ||
        state.title == null ||
        state.eventDate == null) {
      return notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Fehler",
          message: "Bitte fülle alle verpflichtenen Felder aus",
        ),
      );
    }

    emitState(status: AddPrivateEventStateStatus.loading);

    final Either<NotificationAlert, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.createPrivateEventViaApi(
      CreatePrivateEventDto(
        title: state.title!,
        description: state.description,
        coverImage: state.coverImage!,
        groupchatTo: state.selectedGroupchat?.id,
        eventDate: state.eventDate!,
        eventEndDate: state.eventEndDate,
        privateEventUsers: state.privateEventUsersDto,
        eventLocation: state.city != null &&
                state.zip != null &&
                state.housenumber != null &&
                state.street != null &&
                state.city!.isNotEmpty &&
                state.zip!.isNotEmpty &&
                state.housenumber!.isNotEmpty &&
                state.street!.isNotEmpty
            ? CreatePrivateEventLocationDto(
                city: state.city!,
                country: "DE",
                housenumber: state.housenumber!,
                street: state.street!,
                zip: state.zip!,
              )
            : null,
      ),
    );

    privateEventOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(status: AddPrivateEventStateStatus.initial);
      },
      (privateEvent) {
        homeEventCubit.getFuturePrivateEventsViaApi(reload: true);
        emit(AddPrivateEventState(
          privateEventUsersDto: [],
          calendarTimeUsers: [],
          isGroupchatEvent: false,
          status: AddPrivateEventStateStatus.success,
          addedPrivateEvent: privateEvent,
        ));
      },
    );
  }

  void addPrivateEventUserToList({
    required CreatePrivateEventUserFromPrivateEventDtoWithUserEntity
        privateEventUserDto,
  }) {
    emitState(
      privateEventUsersDto: List.from(state.privateEventUsersDto)
        ..add(privateEventUserDto),
    );
    getCalendarTimeUsers();
  }

  void removePrivateEventUserFromList({
    required String userId,
  }) {
    emitState(
      privateEventUsersDto: state.privateEventUsersDto
          .where(
            (element) => element.userId != userId,
          )
          .toList(),
    );
    getCalendarTimeUsers();
  }

  void setIsGroupchatEvent({required bool isGroupchatEvent}) {
    emitState(
      isGroupchatEvent: isGroupchatEvent,
      calendarTimeUsers: [],
      privateEventUsersDto: isGroupchatEvent == true ? [] : null,
      resetSelectedGroupchat: isGroupchatEvent == false ? true : false,
    );
  }

  Future getCalendarTimeUsers() async {
    if ((state.selectedGroupchat == null && state.privateEventUsersDto == []) ||
        (state.eventDate == null)) {
      return;
    }
    emitState(loadingCalendarTimeUsers: true);

    final timeByUsersOrAlert = await calendarUseCases.checkTimeByUsers(
      checkTimeByUsersCalendarFilter: CheckTimeByUsersCalendarFilter(
        startDate: state.eventDate!,
        endDate: state.eventEndDate,
        groupchatId: state.isGroupchatEvent && state.selectedGroupchat != null
            ? state.selectedGroupchat!.id
            : null,
        userIds: state.isGroupchatEvent == false
            ? state.privateEventUsersDto.map((e) => e.user.id).toList()
            : null,
      ),
    );

    timeByUsersOrAlert.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(loadingCalendarTimeUsers: false);
      },
      (users) {
        emitState(calendarTimeUsers: users, loadingCalendarTimeUsers: false);
      },
    );
  }

  void emitState({
    String? title,
    String? description,
    File? coverImage,
    List<CreatePrivateEventUserFromPrivateEventDtoWithUserEntity>?
        privateEventUsersDto,
    GroupchatEntity? selectedGroupchat,
    bool resetSelectedGroupchat = false,
    DateTime? eventDate,
    DateTime? eventEndDate,
    String? country,
    String? zip,
    String? city,
    String? street,
    String? housenumber,
    bool? isGroupchatEvent,
    AddPrivateEventStateStatus? status,
    PrivateEventEntity? addedPrivateEvent,
    List<CalendarTimeUserEntity>? calendarTimeUsers,
    bool? loadingCalendarTimeUsers,
  }) {
    emit(AddPrivateEventState(
      isGroupchatEvent: isGroupchatEvent ?? state.isGroupchatEvent,
      privateEventUsersDto: privateEventUsersDto ?? state.privateEventUsersDto,
      title: title ?? state.title,
      description: description ?? state.description,
      coverImage: coverImage ?? state.coverImage,
      selectedGroupchat: resetSelectedGroupchat
          ? null
          : selectedGroupchat ?? state.selectedGroupchat,
      eventDate: eventDate ?? state.eventDate,
      eventEndDate: eventEndDate ?? state.eventEndDate,
      country: country ?? state.country,
      zip: zip ?? state.zip,
      city: city ?? state.city,
      street: street ?? state.street,
      housenumber: housenumber ?? state.housenumber,
      status: status ?? AddPrivateEventStateStatus.initial,
      calendarTimeUsers: calendarTimeUsers ?? state.calendarTimeUsers,
      addedPrivateEvent: addedPrivateEvent,
      loadingCalendarTimeUsers:
          loadingCalendarTimeUsers ?? state.loadingCalendarTimeUsers,
    ));
  }
}
