import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/add_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';

class NewPrivateEventWrapperPage extends StatelessWidget {
  const NewPrivateEventWrapperPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPrivateEventCubit, AddPrivateEventState>(
      listener: (context, state) async {
        if (state is AddPrivateEventLoaded) {
          AutoRouter.of(context).root.push(
                PrivateEventPageRoute(
                  privateEventId: state.addedPrivateEvent.id,
                  loadPrivateEventFromApiToo: false,
                  privateEventToSet: state.addedPrivateEvent,
                ),
              );
        } else if (state is AddPrivateEventError) {
          return await showPlatformDialog(
            context: context,
            builder: (context) {
              return PlatformAlertDialog(
                title: Text(state.title),
                content: Text(state.message),
                actions: const [OKButton()],
              );
            },
          );
        }
      },
      child: const AutoRouter(),
    );
  }
}
