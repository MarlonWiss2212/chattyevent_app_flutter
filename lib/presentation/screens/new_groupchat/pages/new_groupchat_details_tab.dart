import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_groupchat/add_groupchat_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/circle_image/select_circle_image.dart';

@RoutePage()
class NewGroupchatDetailsTab extends StatefulWidget {
  const NewGroupchatDetailsTab({super.key});

  @override
  State<NewGroupchatDetailsTab> createState() => _NewGroupchatDetailsTabState();
}

class _NewGroupchatDetailsTabState extends State<NewGroupchatDetailsTab> {
  FocusNode descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: BlocBuilder<AddGroupchatCubit, AddGroupchatState>(
          buildWhen: (previous, current) {
            return previous.profileImage?.path != current.profileImage?.path;
          },
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 20),
                SelectCircleImage(
                  imageChanged: (newImage) {
                    if (newImage == null) {
                      BlocProvider.of<AddGroupchatCubit>(context).emitState(
                        removeProfileImage: true,
                      );
                    } else {
                      BlocProvider.of<AddGroupchatCubit>(context).emitState(
                        profileImage: newImage,
                      );
                    }
                  },
                  image: state.profileImage,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: TextEditingController(
                    text: state.title,
                  ),
                  onChanged: (value) =>
                      BlocProvider.of<AddGroupchatCubit>(context).emitState(
                    title: value,
                  ),
                  decoration: const InputDecoration(labelText: "Name*"),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: TextEditingController(text: state.description),
                  focusNode: descriptionFocusNode,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    labelText: "Beschreibung (optional)",
                  ),
                  onTapOutside: (event) => descriptionFocusNode.unfocus(),
                  onChanged: (value) =>
                      BlocProvider.of<AddGroupchatCubit>(context).emitState(
                    description: value,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
