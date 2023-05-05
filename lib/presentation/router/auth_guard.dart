import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chattyevent_app_flutter/core/injection.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final currentUser = serviceLocator<FirebaseAuth>().currentUser;

    if (currentUser != null && currentUser.emailVerified) {
      resolver.next(true);
    } else if (currentUser != null && currentUser.emailVerified == false) {
      router.replace(const VerifyEmailPageRoute());
    } else {
      router.replace(const LoginPageRoute());
    }
  }
}
