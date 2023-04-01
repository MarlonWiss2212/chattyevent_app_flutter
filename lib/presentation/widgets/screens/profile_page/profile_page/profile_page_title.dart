import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/input_fields/edit_input_text_field.dart';

class ProfilePageTitle extends StatelessWidget {
  const ProfilePageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          previous.currentUser.id != current.currentUser.id,
      builder: (context, authState) {
        return BlocBuilder<ProfilePageCubit, ProfilePageState>(
          buildWhen: (previous, current) =>
              previous.user.username != current.user.username,
          builder: (context, state) {
            return Hero(
              tag: "${state.user.id} username",
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: EditInputTextField(
                  text: state.user.username ?? "Profilseite",
                  textStyle: Theme.of(context).textTheme.titleLarge?.apply(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                  editable: authState.currentUser.id == state.user.id,
                  onSaved: (text) {
                    print(text);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
