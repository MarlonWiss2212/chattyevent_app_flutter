import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_private_event/add_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/new_private_event/new_private_event_details_tab/select_cover_image.dart';

@RoutePage()
class NewPrivateEventDetailsTab extends StatefulWidget {
  const NewPrivateEventDetailsTab({super.key});

  @override
  State<NewPrivateEventDetailsTab> createState() =>
      _NewPrivateEventDetailsTabState();
}

class _NewPrivateEventDetailsTabState extends State<NewPrivateEventDetailsTab> {
  FocusNode descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<AddPrivateEventCubit, AddPrivateEventState>(
        buildWhen: (previous, current) {
          if (previous.coverImage?.path != current.coverImage?.path) {
            return true;
          }
          if (previous.selectedGroupchat?.id != current.selectedGroupchat?.id) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 8),
              SelectCoverImage(
                imageChanged: (newImage) {
                  BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                    coverImage: newImage,
                  );
                },
                image: state.coverImage,
              ),
              const SizedBox(height: 8),
              PlatformTextFormField(
                controller: TextEditingController(
                  text: state.title,
                ),
                onChanged: (value) =>
                    BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                  title: value,
                ),
                hintText: 'Name*',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: TextField(
                  controller: TextEditingController(text: state.description),
                  focusNode: descriptionFocusNode,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 10,
                  decoration: const InputDecoration.collapsed(
                    hintText: "Beschreibung",
                  ),
                  onTapOutside: (event) => descriptionFocusNode.unfocus(),
                  onChanged: (value) =>
                      BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                    description: value,
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          );
        },
      ),
    );
  }
}
