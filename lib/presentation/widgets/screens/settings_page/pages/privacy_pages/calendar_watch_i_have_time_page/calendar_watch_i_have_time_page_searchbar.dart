import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/input_fields/debounce_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarWatchIHaveTimePageSearchbar extends StatelessWidget {
  const CalendarWatchIHaveTimePageSearchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: IntrinsicHeight(
        child: DebouceInputField(
          searchController: TextEditingController(),
          onSearchChanged: ({required String text}) {
            BlocProvider.of<UserSearchCubit>(context).getFollowersViaApi(
              search: text,
              sortForCalendarWatchIHaveTimeAllowedUsersFirst: true,
            );
          },
          hintText: "User Suche: ",
        ),
      ),
    );
  }
}
