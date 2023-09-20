import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/ad_helper.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/ads/custom_native_ad.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/event_list/event_horizontal_list.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeEventPageDetails extends StatelessWidget {
  const HomeEventPageDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          BlocBuilder<HomeEventCubit, HomeEventState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.futureEvents.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "homePage.pages.eventPage.nextEvents",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ).tr(),
                          TextButton(
                            onPressed: () => AutoRouter.of(context).push(
                              const FutureEventsRoute(),
                            ),
                            child: const Text("general.showAllText").tr(),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      EventHorizontalList(
                        key: const Key("EventHorizontalListFuture"),
                        eventStates: state.futureEvents,
                      ),
                    ],
                    if (state.pastEvents.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "homePage.pages.eventPage.lastEvents",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ).tr(),
                          TextButton(
                            onPressed: () => AutoRouter.of(context).push(
                              const PastEventsRoute(),
                            ),
                            child: const Text("general.showAllText").tr(),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      EventHorizontalList(
                        key: const Key("EventHorizontalListPast"),
                        eventStates: state.pastEvents,
                      ),
                    ],
                    const SizedBox(height: 8),
                  ],
                ),
              );
            },
          ),
          Center(
            child: CustomNativeAd(
              adUnitId: AdHelper.privateEventListNativeAdUnitId,
              maxWidth: MediaQuery.of(context).size.width - 16,
              minWidth: MediaQuery.of(context).size.width - 16,
              maxHeight: 400,
              minHeight: 400,
              templateType: TemplateType.medium,
            ),
          ),
        ],
      ),
    );
  }
}
