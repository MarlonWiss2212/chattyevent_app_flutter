import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/add_groupchat_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/circle_image/select_circle_image.dart';

class NewGroupchatDetailsTab extends StatelessWidget {
  const NewGroupchatDetailsTab({super.key});

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
                    BlocProvider.of<AddGroupchatCubit>(context).emitState(
                      profileImage: newImage,
                    );
                  },
                  image: state.profileImage,
                ),
                const SizedBox(height: 20),
                PlatformTextFormField(
                  controller: TextEditingController(
                    text: state.title,
                  ),
                  onChanged: (value) =>
                      BlocProvider.of<AddGroupchatCubit>(context).emitState(
                    title: value,
                  ),
                  hintText: 'Name*',
                ),
                const SizedBox(height: 8),
                PlatformTextFormField(
                  controller: TextEditingController(
                    text: state.description,
                  ),
                  onChanged: (value) =>
                      BlocProvider.of<AddGroupchatCubit>(context).emitState(
                    description: value,
                  ),
                  hintText: 'Beschreibung',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}