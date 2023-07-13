import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/home_page/pages/home_event_page/home_event_page_shopping_list_tile.dart';
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
                    if (state.futurePrivateEvents.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Nächste Events",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          TextButton(
                            onPressed: () => AutoRouter.of(context).push(
                              const FutureEventsRoute(),
                            ),
                            child: const Text("Alle Anzeigen"),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      EventHorizontalList(
                          privateEventStates: state.futurePrivateEvents),
                    ],
                    if (state.pastPrivateEvents.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Letzte Events",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          TextButton(
                            onPressed: () => AutoRouter.of(context).push(
                              const PastEventsRoute(),
                            ),
                            child: const Text("Alle Anzeigen"),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      EventHorizontalList(
                        privateEventStates: state.pastPrivateEvents,
                      ),
                    ],
                    const SizedBox(height: 20),
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
              maxHeight: 320,
              minHeight: 320,
              templateType: TemplateType.medium,
            ),
          ),
          const SizedBox(height: 8),
          const HomeEventPageShoppingListTile(),
        ],
      ),
    );
  }
}
