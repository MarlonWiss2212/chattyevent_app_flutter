import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthCubit authCubit;
  AuthGuard({required this.authCubit});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final currentUserOrFailure = authCubit.authUseCases.getFirebaseUser();

    currentUserOrFailure.fold(
      (_) {
        resolver.redirect(const LoginRoute(), replace: true);
      },
      (user) {
        if (user.emailVerified) {
          resolver.next(true);
        } else {
          resolver.redirect(const VerifyEmailRoute(), replace: true);
        }
      },
    );
  }
}
