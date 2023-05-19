part of 'home_event_cubit.dart';

class HomeEventState {
  final List<CurrentPrivateEventState> privateEvents;

  final int futureOffset;
  final int pastOffset;

  final bool loadingFutureEvents;
  final bool loadingPastEvents;

  List<CurrentPrivateEventState> getFutureEvents() {
    return privateEvents
        .where((element) =>
            element.privateEvent.eventDate.compareTo(DateTime.now()) >= 0)
        .toList();
  }

  List<CurrentPrivateEventState> getPastEvents() {
    final pastEvents = privateEvents.where((element) {
      return DateTime.now().compareTo(element.privateEvent.eventDate) >= 0;
    }).toList();
    pastEvents.sort(
      (a, b) => b.privateEvent.eventDate.compareTo(a.privateEvent.eventDate),
    );
    return pastEvents;
  }

  const HomeEventState({
    required this.privateEvents,
    required this.futureOffset,
    required this.pastOffset,
    // but not in emitState function
    this.loadingFutureEvents = false,
    this.loadingPastEvents = false,
  });
}
