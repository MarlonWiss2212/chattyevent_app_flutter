import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:social_media_app_flutter/core/utils/ad_helper.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/ads/custom_banner_ad.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/event_list/event_horizontal_list.dart';

class HomeEventPageDetails extends StatelessWidget {
  const HomeEventPageDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          BlocBuilder<HomeEventCubit, HomeEventState>(
            builder: (context, state) {
              final futureEvents = state.getFutureEvents();
              final pastEvents = state.getPastEvents();

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (futureEvents.isNotEmpty) ...[
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
                              const FutureEventsPageRoute(),
                            ),
                            child: const Text("Alle Anzeigen"),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      EventHorizontalList(privateEvents: futureEvents),
                    ],
                    if (pastEvents.isNotEmpty) ...[
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
                              const PastEventsPageRoute(),
                            ),
                            child: const Text("Alle Anzeigen"),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      EventHorizontalList(privateEvents: pastEvents),
                    ],
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
          CustomBannerAd(adUnitId: AdHelper.bannerAdUnitId),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text("Einkaufsliste"),
            onTap: () {
              AutoRouter.of(context).push(
                const ShoppingListWrapperPageRoute(
                  children: [ShoppingListPageRoute()],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
