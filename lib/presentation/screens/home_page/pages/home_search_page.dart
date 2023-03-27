import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_search_cubit.dart';
import 'package:social_media_app_flutter/core/filter/get_users_filter.dart';
import '../../../widgets/screens/home_page/pages/home_search_page/user_horizontal_list.dart';

class HomeSearchPage extends StatelessWidget {
  const HomeSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserSearchCubit>(context).getUsersViaApi();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Entdecken"),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                PlatformTextFormField(
                  onChanged: (text) {
                    BlocProvider.of<UserSearchCubit>(context).getUsersViaApi(
                      getUsersFilter: GetUsersFilter(
                        search: text,
                      ),
                    );
                  },
                  hintText: "User Suche:",
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
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
