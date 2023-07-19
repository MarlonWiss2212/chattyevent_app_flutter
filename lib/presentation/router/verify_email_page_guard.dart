import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class VerifyEmailPageGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final currentUser = serviceLocator<FirebaseAuth>().currentUser;

    if (currentUser == null) {
      resolver.redirect(const LoginRoute(), replace: true);
    } else if (currentUser.emailVerified == false) {
      resolver.next(true);
    } else {
      resolver.redirect(
        const BlocInitRoute(
          children: [HomeRoute()],
        ),
        replace: true,
      );
    }
  }
}
