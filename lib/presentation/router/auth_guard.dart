import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chattyevent_app_flutter/core/injection.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  AuthCubit authCubit;
  AuthGuard({required this.authCubit});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final currentUser = serviceLocator<FirebaseAuth>().currentUser;

    if (currentUser != null) {
      await authCubit.refreshJwtToken();

      if (currentUser.emailVerified &&
          authCubit.state.isUserCode404() == false) {
        resolver.next(true);
      } else if (currentUser.emailVerified) {
        router.replace(const CreateUserPageRoute());
      } else {
        router.replace(const VerifyEmailPageRoute());
      }
    } else {
      router.replace(const LoginPageRoute());
    }
  }
}
