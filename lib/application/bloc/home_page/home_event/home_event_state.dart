part of 'home_event_cubit.dart';

class HomeEventState {
  final List<CurrentEventState> futurePrivateEvents;
  final List<CurrentEventState> pastPrivateEvents;

  final bool loadingFutureEvents;
  final bool loadingPastEvents;

  const HomeEventState({
    required this.futurePrivateEvents,
    required this.pastPrivateEvents,
    // but not in emitState function
    this.loadingFutureEvents = false,
    this.loadingPastEvents = false,
  });
}
