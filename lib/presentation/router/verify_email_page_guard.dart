import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chattyevent_app_flutter/core/injection.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class VerifyEmailPageGuard extends AutoRouteGuard {
  AuthCubit authCubit;
  VerifyEmailPageGuard({required this.authCubit});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final currentUser = serviceLocator<FirebaseAuth>().currentUser;

    if (currentUser == null) {
      router.replace(const LoginPageRoute());
    } else if (currentUser.emailVerified == false) {
      resolver.next(true);
    } else {
      router.replace(const HomePageRoute());
    }
  }
}
