import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_event/add_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/custom_divider.dart';

@RoutePage()
class NewPrivateEventTypeTab extends StatelessWidget {
  const NewPrivateEventTypeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEventCubit, AddEventState>(
      buildWhen: (p, c) => p.isGroupchatEvent != c.isGroupchatEvent,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => BlocProvider.of<AddEventCubit>(context)
                      .setIsGroupchatEvent(isGroupchatEvent: true),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: state.isGroupchatEvent
                        ? BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(8),
                          )
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.chat),
                          Text(
                            "newPrivateEventPage.pages.eventTypTab.privateGroupchatEvent.title",
                            style: Theme.of(context).textTheme.labelLarge,
                          ).tr(),
                          const Text(
                            "newPrivateEventPage.pages.eventTypTab.privateGroupchatEvent.description",
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                          ).tr(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const CustomDivider(),
              Expanded(
                child: InkWell(
                  onTap: () => BlocProvider.of<AddEventCubit>(context)
                      .setIsGroupchatEvent(isGroupchatEvent: false),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: state.isGroupchatEvent == false
                        ? BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(8),
                          )
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.person),
                          Text(
                            "newPrivateEventPage.pages.eventTypTab.normalPrivateEvent.title",
                            style: Theme.of(context).textTheme.labelLarge,
                          ).tr(),
                          const Text(
                            "newPrivateEventPage.pages.eventTypTab.normalPrivateEvent.description",
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                          ).tr(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
