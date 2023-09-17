import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_event/add_event_cubit.dart';
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
      child: BlocBuilder<AddEventCubit, AddEventState>(
        buildWhen: (previous, current) {
          if (previous.coverImage?.path != current.coverImage?.path) {
            return true;
          }
          if (previous.selectedGroupchat?.id != current.selectedGroupchat?.id) {
            return true;
          }
          if (previous.autoDelete != current.autoDelete) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          return Column(
            children: [
              SelectCoverImage(
                imageChanged: (newImage) {
                  if (newImage == null) {
                    BlocProvider.of<AddEventCubit>(context).emitState(
                      removeCoverImage: true,
                    );
                  } else {
                    BlocProvider.of<AddEventCubit>(context).emitState(
                      coverImage: newImage,
                    );
                  }
                },
                image: state.coverImage,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: TextEditingController(
                  text: state.title,
                ),
                onChanged: (value) =>
                    BlocProvider.of<AddEventCubit>(context).emitState(
                  title: value,
                ),
                decoration: InputDecoration(
                  labelText: 'newGroupchatPage.fields.nameField.lable'.tr(),
                ),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: TextEditingController(text: state.description),
                focusNode: descriptionFocusNode,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 10,
                decoration: InputDecoration(
                  labelText:
                      'newGroupchatPage.fields.descriptionField.lable'.tr(),
                ),
                onTapOutside: (event) => descriptionFocusNode.unfocus(),
                onChanged: (value) =>
                    BlocProvider.of<AddEventCubit>(context).emitState(
                  description: value,
                ),
              ),
              const SizedBox(height: 8),
              SwitchListTile.adaptive(
                title: const Text(
                  "newGroupchatPage.fields.deleteAfterEndDateSwitch.title",
                ).tr(),
                value: state.autoDelete,
                onChanged: (value) =>
                    BlocProvider.of<AddEventCubit>(context).emitState(
                  autoDelete: value,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
