part of 'add_private_event_cubit.dart';

enum AddPrivateEventStateStatus { initial, loading, success, error }

class AddPrivateEventState {
  final PrivateEventEntity? addedPrivateEvent;
  final ErrorWithTitleAndMessage? error;
  final AddPrivateEventStateStatus status;

  final String? title;
  final String? description;
  final File? coverImage;
  final DateTime? eventDate;

  final GroupchatEntity? selectedGroupchat;

  // create private event location
  final String? country;
  final String? zip;
  final String? city;
  final String? street;
  final String? housenumber;

  AddPrivateEventState({
    this.addedPrivateEvent,
    this.error,
    this.status = AddPrivateEventStateStatus.initial,
    this.title,
    this.description,
    this.coverImage,
    this.selectedGroupchat,
    this.eventDate,
    this.city,
    this.country,
    this.housenumber,
    this.street,
    this.zip,
  });
}
