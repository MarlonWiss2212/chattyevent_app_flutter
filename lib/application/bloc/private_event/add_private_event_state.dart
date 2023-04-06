part of 'add_private_event_cubit.dart';

enum AddPrivateEventStateStatus { initial, loading, success }

class AddPrivateEventState {
  final PrivateEventEntity? addedPrivateEvent;
  final AddPrivateEventStateStatus status;

  final String? title;
  final String? description;
  final File? coverImage;
  final DateTime? eventDate;
  final DateTime? eventEndDate;

  // if event is a normal or groupchat event type
  final bool isGroupchatEvent;

  final GroupchatEntity? selectedGroupchat;

  final List<CreatePrivateEventUserFromPrivateEventDtoWithUserEntity>
      privateEventUsersDto;

  // create private event location
  final String? country;
  final String? zip;
  final String? city;
  final String? street;
  final String? housenumber;

  AddPrivateEventState({
    this.addedPrivateEvent,
    this.status = AddPrivateEventStateStatus.initial,
    this.title,
    required this.privateEventUsersDto,
    required this.isGroupchatEvent,
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
