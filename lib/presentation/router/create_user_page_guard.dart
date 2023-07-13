import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class CreateUserPageGuard extends AutoRouteGuard {
  final AuthCubit authCubit;
  CreateUserPageGuard({required this.authCubit});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final currentUser = serviceLocator<FirebaseAuth>().currentUser;

    if (currentUser != null) {
      if (authCubit.state.isUserCode404() ||
          currentUser.emailVerified && authCubit.state.currentUser.id == "") {
        resolver.next(true);
      } else if (currentUser.emailVerified == false) {
        resolver.redirect(const VerifyEmailRoute());
      } else {
        resolver.redirect(const BlocInitRoute(children: [HomeRoute()]));
      }
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}
