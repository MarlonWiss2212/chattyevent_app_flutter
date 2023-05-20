import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/core/utils/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/event_list/event_horizontal_list_item.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class EventHorizontalList extends StatefulWidget {
  final List<CurrentPrivateEventState> privateEventStates;
  const EventHorizontalList({super.key, required this.privateEventStates});

  @override
  State<EventHorizontalList> createState() => _EventHorizontalListState();
}

class _EventHorizontalListState extends State<EventHorizontalList> {
  NativeAd? _ad;

  @override
  void initState() {
    _ad = NativeAd(
      adUnitId: AdHelper.privateEventHorizontalListNativeAdUnitId,
      listener: NativeAdListener(
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: Colors.purple,
        cornerRadius: 8,
      ),
    )..load();

    super.initState();
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double viewportFraction = min(
      (300 / MediaQuery.of(context).size.width).toDouble(),
      1,
    );
    final pageController = PageController(viewportFraction: viewportFraction);
    // to make the box in the 4 by 3 ratio just like the image is
    // -16 is the padding
    final width = (MediaQuery.of(context).size.width * viewportFraction) - 16;
    final height = width / 4 * 3;

    return SizedBox(
      height: height,
      child: PageView.builder(
        padEnds: false,
        controller: pageController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == 1 && _ad != null) {
            return Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              width: width,
              height: height,
              child: AdWidget(ad: _ad!),
            );
          }
          return FractionallySizedBox(
            widthFactor: .95,
            alignment: Alignment.centerLeft,
            child: EventHorizontalListItem(
              height: height,
              width: width,
              privateEvent: widget.privateEventStates[index].privateEvent,
              onPress: () {
                AutoRouter.of(context).push(
                  PrivateEventWrapperPageRoute(
                    privateEventStateToSet: widget.privateEventStates[index],
                    privateEventId:
                        widget.privateEventStates[index].privateEvent.id,
                  ),
                );
              },
            ),
          );
        },
        itemCount: _ad != null
            ? widget.privateEventStates.length - 1
            : widget.privateEventStates.length,
      ),
    );
  }
}
