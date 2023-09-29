import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class AuthorizedGuard extends AutoRouteGuard {
  final AuthCubit authCubit;
  AuthorizedGuard({required this.authCubit});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final currentUserOrFailure = authCubit.authUseCases.getFirebaseUser();

    currentUserOrFailure.fold(
      (_) => resolver.redirect(const LoginRoute(), replace: true),
      (user) => resolver.next(true),
    );
  }
}
