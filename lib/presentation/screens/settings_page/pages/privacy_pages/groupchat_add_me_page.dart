import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/settings_page/pages/privacy_pages/groupchat_add_me_page/groupchat_add_me_page_chip_list.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/settings_page/pages/privacy_pages/groupchat_add_me_page/groupchat_add_me_page_user_list.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/settings_page/pages/privacy_pages/groupchat_add_me_page/groupchat_add_me_searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupchatAddMePage extends StatelessWidget {
  const GroupchatAddMePage({super.key});

  Widget initBloc(BuildContext context, {required Widget child}) {
    return BlocProvider.value(
      value: UserSearchCubit(
        authCubit: BlocProvider.of<AuthCubit>(context),
        userRelationUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
        userUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
        notificationCubit: BlocProvider.of<NotificationCubit>(context),
      )..getFollowersViaApi(), // ..getFollowersViaApi(filterForGroupchatAddMeAllowedUsers: true),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return initBloc(
      context,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Gruppenchat Hinzufüge Berechtigung"),
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              GroupchatAddMePageChipList(),
              GroupchatAddMeSearchbar(),
              SizedBox(height: 8),
              GroupchatAddMePageUserList(),
            ],
          ),
        ),
      ),
    );
  }
}
