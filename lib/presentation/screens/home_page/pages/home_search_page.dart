import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_search_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/banner_ad_user_list.dart';
import 'package:social_media_app_flutter/presentation/widgets/home_page/pages/home_search_page/user_grid_list_with_searchbar.dart';

class HomeSearchPage extends StatelessWidget {
  const HomeSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserSearchCubit>(context).getUsersViaApi();

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Social Media App'),
      ),
      body: Column(
        children: const [
          Expanded(child: UserGridListWithSearchbar()),
          BannerAdUserList(),
        ],
      ),
    );
  }
}
