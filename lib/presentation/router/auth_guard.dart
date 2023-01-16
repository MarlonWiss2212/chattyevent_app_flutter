import 'package:auto_route/auto_route.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  AuthState state;
  AuthGuard({required this.state});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (state is AuthStateLoaded) {
      resolver.next(true);
    } else {
      router.replace(const LoginPageRoute());
    }
  }
}
