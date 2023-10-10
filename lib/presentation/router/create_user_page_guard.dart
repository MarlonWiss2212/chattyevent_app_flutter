import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class CreateUserPageGuard extends AutoRouteGuard {
  final AuthCubit authCubit;
  CreateUserPageGuard({required this.authCubit});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final currentUserOrFailure = authCubit.authUseCases.getFirebaseUser();

    currentUserOrFailure.fold(
      (_) {
        resolver.redirect(const LoginRoute(), replace: true);
      },
      (user) {
        if (user.emailVerified && authCubit.state.currentUser.id == "") {
          resolver.next(true);
        } else if (user.emailVerified == false) {
          resolver.redirect(const VerifyEmailRoute(), replace: true);
        } else {
          resolver.redirect(
            const HomeRoute(),
            replace: true,
          );
        }
      },
    );
  }
}
