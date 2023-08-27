import 'dart:io';
import 'package:chattyevent_app_flutter/core/enums/event/event_permission_enum.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/create_private_event_data_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/geocoding/create_address_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/create_event_permissions_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/calendar/find_time_by_users_calendar_filter.dart';
import 'package:chattyevent_app_flutter/domain/usecases/calendar_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/create_event_location_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/create_event_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/event_user/create_event_user_from_event_dto.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/event_usecases.dart';
import 'package:chattyevent_app_flutter/domain/entities/calendar/calendar_time_user_entity.dart';
part 'add_event_state.dart';

class AddEventCubit extends Cubit<AddEventState> {
  final HomeEventCubit homeEventCubit;
  final EventUseCases eventUseCases;
  final NotificationCubit notificationCubit;
  final CalendarUseCases calendarUseCases;

  AddEventCubit({
    required this.eventUseCases,
    required this.homeEventCubit,
    required this.calendarUseCases,
    required this.notificationCubit,
  }) : super(AddEventState(
          subtitle: "",
          autoDelete: false,
          permissions: CreateEventPermissionsDto(
            addUsers: EventPermissionEnum.organizersonly,
            changeDescription: EventPermissionEnum.organizersonly,
            changeAddress: EventPermissionEnum.creatoronly,
            changeTitle: EventPermissionEnum.organizersonly,
            changeCoverImage: EventPermissionEnum.creatoronly,
            changeDate: EventPermissionEnum.creatoronly,
            changeStatus: EventPermissionEnum.creatoronly,
            addShoppingListItem: EventPermissionEnum.everyone,
            updateShoppingListItem: EventPermissionEnum.everyone,
            deleteShoppingListItem: EventPermissionEnum.everyone,
          ),
          isGroupchatEvent: false,
          calendarTimeUsers: [],
          privateEventUsersDto: [],
        ));

  Future createEventViaApi() async {
    if (state.title == null || state.eventDate == null) {
      return notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Fehler",
          message: "Bitte fülle alle verpflichtenen Felder aus",
        ),
      );
    }

    emitState(status: AddEventStateStatus.loading);

    final Either<NotificationAlert, EventEntity> eventOrFailure =
        await eventUseCases.createEventViaApi(
      CreateEventDto(
        title: state.title!,
        description: state.description,
        coverImage: state.coverImage,
        autoDelete: state.autoDelete,
        privateEventData: CreatePrivateEventDataDto(
          groupchatTo: state.selectedGroupchat?.id,
        ),
        eventDate: state.eventDate!,
        eventEndDate: state.eventEndDate,
        eventUsers: state.privateEventUsersDto,
        eventLocation: state.city != null &&
                state.zip != null &&
                state.housenumber != null &&
                state.street != null &&
                state.city!.isNotEmpty &&
                state.zip!.isNotEmpty &&
                state.housenumber!.isNotEmpty &&
                state.street!.isNotEmpty
            ? CreateEventLocationDto(
                address: CreateAddressDto(
                  city: state.city!,
                  country: "DE",
                  housenumber: state.housenumber!,
                  street: state.street!,
                  zip: state.zip!,
                ),
              )
            : null,
      ),
    );

    eventOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(status: AddEventStateStatus.initial);
      },
      (event) {
        homeEventCubit.getfutureEventsViaApi(reload: true);
        emit(AddEventState(
          autoDelete: false,
          subtitle: "",
          permissions: CreateEventPermissionsDto(),
          privateEventUsersDto: [],
          calendarTimeUsers: [],
          isGroupchatEvent: false,
          status: AddEventStateStatus.success,
          addedEvent: event,
        ));
      },
    );
  }

  void addPrivateEventUserToList({
    required CreateEventUserFromEventDtoWithUserEntity privateEventUserDto,
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
    if ((state.selectedGroupchat == null &&
            state.privateEventUsersDto.isEmpty) ||
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
    List<CreateEventUserFromEventDtoWithUserEntity>? privateEventUsersDto,
    GroupchatEntity? selectedGroupchat,
    bool resetSelectedGroupchat = false,
    DateTime? eventDate,
    bool removeEventDate = false,
    DateTime? eventEndDate,
    bool removeEventEndDate = false,
    String? country,
    String? zip,
    String? city,
    String? street,
    String? housenumber,
    bool? isGroupchatEvent,
    bool? autoDelete,
    AddEventStateStatus? status,
    EventEntity? addedEvent,
    List<CalendarTimeUserEntity>? calendarTimeUsers,
    CreateEventPermissionsDto? permissions,
    bool? loadingCalendarTimeUsers,
    String? subtitle,
  }) {
    emit(AddEventState(
      autoDelete: autoDelete ?? state.autoDelete,
      subtitle: subtitle ?? state.subtitle,
      permissions: permissions ?? state.permissions,
      isGroupchatEvent: isGroupchatEvent ?? state.isGroupchatEvent,
      privateEventUsersDto: privateEventUsersDto ?? state.privateEventUsersDto,
      title: title ?? state.title,
      description: description ?? state.description,
      coverImage: coverImage ?? state.coverImage,
      selectedGroupchat: resetSelectedGroupchat
          ? null
          : selectedGroupchat ?? state.selectedGroupchat,
      eventDate: removeEventDate == false ? eventDate ?? state.eventDate : null,
      eventEndDate: removeEventEndDate == false
          ? eventEndDate ?? state.eventEndDate
          : null,
      country: country ?? state.country,
      zip: zip ?? state.zip,
      city: city ?? state.city,
      street: street ?? state.street,
      housenumber: housenumber ?? state.housenumber,
      status: status ?? AddEventStateStatus.initial,
      calendarTimeUsers: calendarTimeUsers ?? state.calendarTimeUsers,
      addedEvent: addedEvent,
      loadingCalendarTimeUsers:
          loadingCalendarTimeUsers ?? state.loadingCalendarTimeUsers,
    ));
  }
}
