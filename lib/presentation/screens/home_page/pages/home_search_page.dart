import 'package:auto_route/annotations.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/input_fields/debounce_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/user/find_users_filter.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import '../../../widgets/screens/home_page/pages/home_search_page/user_horizontal_list.dart';

@RoutePage()
class HomeSearchPage extends StatelessWidget {
  const HomeSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserSearchCubit(
        authCubit: BlocProvider.of<AuthCubit>(context),
        userRelationUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
        userUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
        notificationCubit: BlocProvider.of<NotificationCubit>(context),
      )..getUsersViaApi(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                snap: true,
                floating: true,
                expandedHeight: 100,
                centerTitle: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    "Entdecken",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const SizedBox(height: 8),
                      DebouceInputField(
                        searchController: TextEditingController(),
                        onSearchChanged: ({required String text}) =>
                            BlocProvider.of<UserSearchCubit>(context)
                                .getUsersViaApi(
                          findUsersFilter: FindUsersFilter(search: text),
                        ),
                        hintText: "User Suche: ",
                      ),
                      const SizedBox(height: 8),
                      BlocBuilder<UserSearchCubit, UserSearchState>(
                        builder: (context, state) {
                          if (state.status == UserSearchStateStatus.loading) {
                            return Center(
                              child: PlatformCircularProgressIndicator(),
                            );
                          }
                          return UserHorizontalList(users: state.users);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
