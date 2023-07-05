import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_permissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrivacyPageCalendarWatchIHaveTimeSwitch extends StatelessWidget {
  const PrivacyPageCalendarWatchIHaveTimeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (p, c) =>
          p.currentUser.permissions?.calendarWatchIHaveTime !=
          c.currentUser.permissions?.calendarWatchIHaveTime,
      builder: (context, state) {
        return SwitchListTile.adaptive(
          title: const Text(
            "Kalender, follower können sehen ob du an einen Termin Zeit hast",
          ),
          value: state.currentUser.permissions?.calendarWatchIHaveTime ?? false,
          onChanged: (newValue) {
            BlocProvider.of<AuthCubit>(context).updateUser(
              updateUserDto: UpdateUserDto(
                permissions: UpdateUserPermissionsDto(
                  calendarWatchIHaveTime: newValue,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
