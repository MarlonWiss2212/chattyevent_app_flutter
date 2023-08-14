part of 'add_event_cubit.dart';

enum AddEventStateStatus { initial, loading, success }

class AddEventState {
  final EventEntity? addedEvent;
  final AddEventStateStatus status;

  final String subtitle;

  final String? title;
  final String? description;
  final File? coverImage;
  final DateTime? eventDate;
  final DateTime? eventEndDate;
  final bool autoDelete;

  // if event is a normal or groupchat event type
  final bool isGroupchatEvent;
  final GroupchatEntity? selectedGroupchat;
  final List<CreateEventUserFromEventDtoWithUserEntity> privateEventUsersDto;

  final bool loadingCalendarTimeUsers;
  final List<CalendarTimeUserEntity> calendarTimeUsers;

  // create private event location
  final String? country;
  final String? zip;
  final String? city;
  final String? street;
  final String? housenumber;

  final CreateEventPermissionsDto permissions;

  AddEventState({
    this.addedEvent,
    required this.subtitle,
    required this.calendarTimeUsers,
    this.loadingCalendarTimeUsers = false,
    this.status = AddEventStateStatus.initial,
    this.title,
    required this.autoDelete,
    required this.privateEventUsersDto,
    required this.isGroupchatEvent,
    required this.permissions,
    this.description,
    this.coverImage,
    this.selectedGroupchat,
    this.eventDate,
    this.eventEndDate,
    this.city,
    this.country,
    this.housenumber,
    this.street,
    this.zip,
  });
}
