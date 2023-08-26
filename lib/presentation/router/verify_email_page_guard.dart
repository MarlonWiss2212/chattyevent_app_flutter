import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/domain/usecases/auth_usecases.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class VerifyEmailPageGuard extends AutoRouteGuard {
  final AuthUseCases authUseCases;
  const VerifyEmailPageGuard({required this.authUseCases});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final currentUserOrFailure = authUseCases.getFirebaseUser();

    currentUserOrFailure.fold(
      (_) => resolver.redirect(const LoginRoute(), replace: true),
      (user) {
        if (user.emailVerified == false) {
          resolver.next(true);
        } else {
          resolver.redirect(
            const BlocInitRoute(
              children: [HomeRoute()],
            ),
            replace: true,
          );
        }
      },
    );
  }
}
