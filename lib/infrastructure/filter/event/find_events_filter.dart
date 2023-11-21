import 'package:chattyevent_app_flutter/infrastructure/filter/geocoding/geo_within_filter.dart';

class FindEventsFilter {
  final String? groupchatTo;
  final bool? onlyFutureEvents;
  final bool? onlyPastEvents;
  final bool? sortNewestDateFirst;
  final GeoWithinFilter? locationGeoWithin;

  FindEventsFilter({
    this.groupchatTo,
    this.onlyFutureEvents,
    this.onlyPastEvents,
    this.sortNewestDateFirst,
    this.locationGeoWithin,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};

    if (groupchatTo != null) {
      map.addAll({"groupchatTo": groupchatTo});
    }

    if (locationGeoWithin != null) {
      map.addAll({"locationGeoWithin": locationGeoWithin!.toMap()});
    }
    if (onlyFutureEvents != null) {
      map.addAll({"onlyFutureEvents": onlyFutureEvents});
    }
    if (onlyPastEvents != null) {
      map.addAll({"onlyPastEvents": onlyPastEvents});
    }
    if (sortNewestDateFirst != null) {
      map.addAll({"sortNewestDateFirst": sortNewestDateFirst});
    }

    return map;
  }
}
