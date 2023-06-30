import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class AuthPagesGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final currentUser = serviceLocator<FirebaseAuth>().currentUser;

    if (currentUser == null) {
      resolver.next(true);
    } else {
      router.replace(const AuthorizedPageRoute(children: [
        BlocInitPageRoute(children: [HomePageRoute()])
      ]));
    }
  }
}
