import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/domain/usecases/auth_usecases.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class NotAuthenticatedPagesGuard extends AutoRouteGuard {
  final AuthUseCases authUseCases;
  const NotAuthenticatedPagesGuard({required this.authUseCases});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final currentUserOrFailure = authUseCases.getFirebaseUser();

    currentUserOrFailure.fold(
      (_) => resolver.next(true),
      (user) {
        resolver.redirect(
          const AuthorizedRoute(children: [HomeRoute()]),
          replace: true,
        );
      },
    );
  }
}
