import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthCubit authCubit;
  AuthGuard({required this.authCubit});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final currentUserOrFailure = authCubit.authUseCases.getFirebaseUser();

    currentUserOrFailure.fold(
      (_) => resolver.redirect(const LoginRoute(), replace: true),
      (user) {
        if (user.emailVerified && authCubit.state.isUserCode404() == false) {
          resolver.next(true);
        } else if (user.emailVerified) {
          resolver.redirect(const CreateUserRoute(), replace: true);
        } else {
          resolver.redirect(const VerifyEmailRoute(), replace: true);
        }
      },
    );
  }
}
