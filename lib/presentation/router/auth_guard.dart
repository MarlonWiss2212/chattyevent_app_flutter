import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthCubit authCubit;
  AuthGuard({required this.authCubit});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final currentUser = serviceLocator<FirebaseAuth>().currentUser;

    if (currentUser != null) {
      if (currentUser.emailVerified &&
          authCubit.state.isUserCode404() == false) {
        resolver.next(true);
      } else if (currentUser.emailVerified) {
        resolver.redirect(const CreateUserRoute());
      } else {
        resolver.redirect(const VerifyEmailRoute());
      }
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}
