import 'package:chattyevent_app_flutter/application/bloc/requests/requests_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/request/request_horizontal_list_item.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/request/request_horizontal_list_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestHorizontalList extends StatelessWidget {
  const RequestHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    const double viewportFraction = 1.1;
    const double height = 200;

    return BlocBuilder<RequestsCubit, RequestsState>(
      builder: (context, state) {
        if (state.requests.isEmpty && state.loading) {
          return const SizedBox(
            height: height,
            child: RequestHorizontalListSkeleton(),
          );
        } else if (state.requests.isEmpty) {
          return const SizedBox();
        }

        return PageView.builder(
          scrollDirection: Axis.horizontal,
          controller: PageController(viewportFraction: viewportFraction),
          itemBuilder: (context, index) {
            Widget? child;
            if (index > state.requests.length - 1) {
              child = const RequestHorizontalListSkeleton();
            } else {
              child = RequestHorizontalListItem(
                request: state.requests[index],
              );
            }
            return SizedBox(
              height: height,
              child: FractionallySizedBox(
                widthFactor: 1 / viewportFraction,
                child: child,
              ),
            );
          },
          itemCount:
              state.loading ? state.requests.length + 1 : state.requests.length,
        );
      },
    );
  }
}
