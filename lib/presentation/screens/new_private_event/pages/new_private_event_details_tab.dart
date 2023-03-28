import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/add_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/new_private_event/new_private_event_details_tab/select_cover_image.dart';

class NewPrivateEventDetailsTab extends StatelessWidget {
  const NewPrivateEventDetailsTab({super.key});

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
              ),
              const SizedBox(height: 8),
              PlatformTextFormField(
                controller: TextEditingController(
                  text: state.description,
                ),
                onChanged: (value) =>
                    BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                  description: value,
                ),
                hintText: 'Beschreibung',
              ),
              const SizedBox(height: 8),
            ],
          );
        },
      ),
    );
  }
}
