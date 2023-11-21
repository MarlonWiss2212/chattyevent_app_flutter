import 'package:auto_route/annotations.dart';
import 'package:chattyevent_app_flutter/core/utils/ad_helper.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/ads/custom_native_ad.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/input_fields/debounce_input_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/user/find_users_filter.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../widgets/screens/home_page/pages/home_search_page/user_horizontal_list.dart';

@RoutePage()
class HomeSearchPage extends StatelessWidget {
  const HomeSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserSearchCubit(
        authCubit: BlocProvider.of<AuthCubit>(context),
        userRelationUseCases: authenticatedLocator(),
        userUseCases: authenticatedLocator(),
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
                  titlePadding: EdgeInsets.zero,
                  title: Text(
                    "homePage.pages.searchPage.title",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ).tr(),
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
                        hintText: "general.userSearch.userSearchText".tr(),
                      ),
                      const SizedBox(height: 8),
                      BlocBuilder<UserSearchCubit, UserSearchState>(
                        builder: (context, state) {
                          if (state.status == UserSearchStateStatus.loading) {
                            return Center(
                              child: PlatformCircularProgressIndicator(),
                            );
                          }
                          if (state.users.isEmpty) {
                            return Center(
                              child: const Text(
                                      "general.userSearch.noUsersFoundText")
                                  .tr(),
                            );
                          }
                          return UserHorizontalList(users: state.users);
                        },
                      ),
                      const SizedBox(height: 8),
                      CustomNativeAd(
                        adUnitId: AdHelper.discoverPAgeNativeAdUnitId,
                        maxHeight: 400,
                        maxWidth: MediaQuery.of(context).size.width - 16,
                        minHeight: 400,
                        minWidth: MediaQuery.of(context).size.width - 16,
                        templateType: TemplateType.medium,
                      )
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
