import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_private_event/add_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/custom_divider.dart';

class NewPrivateEventTypeTab extends StatelessWidget {
  const NewPrivateEventTypeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () => BlocProvider.of<AddPrivateEventCubit>(context)
                  .setIsGroupchatEvent(isGroupchatEvent: true),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.chat),
                    Text(
                      "Privates Gruppenchat Event",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const Text(
                      "Hierbei verbindest du ein Event mit einem Gruppenchat. Es werden automatisch alle User eingeladen die im Gruppenchat sind. Wenn ein User aus dem Chat geht oder gekickt wird passiert das auch beim Event",
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const CustomDivider(),
          Expanded(
            child: InkWell(
              onTap: () => BlocProvider.of<AddPrivateEventCubit>(context)
                  .setIsGroupchatEvent(isGroupchatEvent: false),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.person),
                    Text(
                      "Normales Privates Event",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const Text(
                      "Du kannst hier User einladen und ausladen unabängig von einem Chat",
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
