import 'package:chattyevent_app_flutter/presentation/widgets/general/input_fields/debounce_input_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_grid_list.dart';

class SelectableUserGridList extends StatefulWidget {
  final void Function(UserEntity user)? onUserPress;

  final void Function({String? text}) reloadRequest;
  final void Function({String? text}) loadMoreRequest;
  final Widget Function(UserEntity)? userButton;
  final bool showTextSearch;

  const SelectableUserGridList({
    super.key,
    this.onUserPress,
    this.userButton,
    required this.reloadRequest,
    required this.loadMoreRequest,
    this.showTextSearch = true,
  });

  @override
  State<SelectableUserGridList> createState() => _SelectableUserGridListState();
}

class _SelectableUserGridListState extends State<SelectableUserGridList> {
  TextEditingController userSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.showTextSearch) ...{
          DebouceInputField(
            searchController: userSearch,
            onSearchChanged: ({required String text}) => widget.reloadRequest(
              text: text,
            ),
            hintText: "general.userSearch.userSearchText".tr(),
          ),
        } else ...[
          SizedBox(
            width: double.infinity,
            child: Button(
              text: "general.reloadText".tr(),
              color: Theme.of(context).colorScheme.surface,
              onTap: () => widget.reloadRequest(),
            ),
          ),
        ],
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: Button(
            text: "general.loadMoreText".tr(),
            color: Theme.of(context).colorScheme.surface,
            onTap: () => widget.loadMoreRequest(text: userSearch.text),
          ),
        ),
        const SizedBox(height: 8),
        BlocBuilder<UserSearchCubit, UserSearchState>(
          builder: (context, state) {
            if (state.status == UserSearchStateStatus.loading &&
                state.users.isNotEmpty) {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            }

            return Expanded(
              child: UserGridList(
                users: state.users,
                onPress: widget.onUserPress,
                button: widget.userButton,
                loadMore: () {
                  widget.loadMoreRequest();
                },
                loading: state.status == UserSearchStateStatus.loadingMore,
              ),
            );
          },
        ),
      ],
    );
  }
}
