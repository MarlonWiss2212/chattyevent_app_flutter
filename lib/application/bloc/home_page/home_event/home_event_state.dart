part of 'home_event_cubit.dart';

enum HomeEventStateStatus { initial, loading, success }

class HomeEventState {
  final List<PrivateEventEntity> privateEvents;

  final int futureOffset;
  final int pastOffset;

  final HomeEventStateStatus status;

  List<PrivateEventEntity> getFutureEvents() {
    return privateEvents
        .where((element) => element.eventDate.compareTo(DateTime.now()) >= 0)
        .toList();
  }

  List<PrivateEventEntity> getPastEvents() {
    final pastEvents = privateEvents
        .where((element) => DateTime.now().compareTo(element.eventDate) >= 0)
        .toList();
    pastEvents.sort((a, b) => b.eventDate.compareTo(a.eventDate));
    return pastEvents;
  }

  const HomeEventState({
    required this.privateEvents,
    required this.futureOffset,
    required this.pastOffset,
    this.status = HomeEventStateStatus.initial,
  });
}
