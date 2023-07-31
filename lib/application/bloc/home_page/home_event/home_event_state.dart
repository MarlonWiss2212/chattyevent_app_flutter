part of 'home_event_cubit.dart';

class HomeEventState {
  final List<CurrentEventState> futureEvents;
  final List<CurrentEventState> pastEvents;

  final bool loadingFutureEvents;
  final bool loadingPastEvents;

  const HomeEventState({
    required this.futureEvents,
    required this.pastEvents,
    // but not in emitState function
    this.loadingFutureEvents = false,
    this.loadingPastEvents = false,
  });
}
