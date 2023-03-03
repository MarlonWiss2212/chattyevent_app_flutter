import 'package:auto_route/auto_route.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  AuthState state;
  AuthGuard({required this.state});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (state.user != null && state.user!.emailVerified) {
      return resolver.next(true);
    } else if (state.user != null && state.user!.emailVerified == false) {
      router.replace(const VerifyEmailPageRoute());
      return;
    }

    router.replace(const LoginPageRoute());
  }
}
