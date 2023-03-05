import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/auth/current_user_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/location/location_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/shopping_list_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_search_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/image/image_cubit.dart';
import 'package:social_media_app_flutter/core/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/main.dart';
import 'package:social_media_app_flutter/presentation/router/auth_guard.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class BlocInit extends StatelessWidget {
  const BlocInit({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter(authGuard: AuthGuard());

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: UserCubit(userUseCases: serviceLocator(param1: state)),
            ),
            BlocProvider.value(
              value: UserSearchCubit(
                userUseCases: serviceLocator(param1: state),
              ),
            ),
            BlocProvider.value(
              value: PrivateEventCubit(
                privateEventUseCases: serviceLocator(param1: state),
              ),
            ),
            BlocProvider.value(
              value: ChatCubit(chatUseCases: serviceLocator(param1: state)),
            ),
            BlocProvider.value(
              value: CurrentUserCubit(
                CurrentUserState(
                  user: UserEntity(
                    id: "",
                    authId:
                        serviceLocator<FirebaseAuth>().currentUser?.uid ?? "",
                  ),
                ),
                userUseCases: serviceLocator(param1: state),
              ),
            ),
            BlocProvider.value(
              value: LocationCubit(locationUseCases: serviceLocator()),
            ),
            BlocProvider.value(
              value: ImageCubit(imagePickerUseCases: serviceLocator()),
            ),
            BlocProvider.value(
              value: ShoppingListCubit(
                shoppingListItemUseCases: serviceLocator(param1: state),
              ),
            ),
          ],
          child: App(authState: state, appRouter: appRouter),
        );
      },
    );
  }
}
