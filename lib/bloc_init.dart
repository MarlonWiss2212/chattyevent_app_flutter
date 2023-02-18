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
import 'package:social_media_app_flutter/core/graphql.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/image_picker_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/location_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/message_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/shopping_list_item_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';
import 'package:social_media_app_flutter/infastructure/datasources/device/image_picker.dart';
import 'package:social_media_app_flutter/infastructure/datasources/device/location.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/respositories/chat_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/device/image_picker_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/device/location_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/message_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/private_event_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/shopping_list_item_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/user_repository_impl.dart';
import 'package:social_media_app_flutter/main.dart';
import 'package:social_media_app_flutter/presentation/router/auth_guard.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class BlocInit extends StatelessWidget {
  const BlocInit({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter(
      authGuard: AuthGuard(
        state: BlocProvider.of<AuthCubit>(context).state,
      ),
    );
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final client = getGraphQlClient(
          token: state is AuthLoaded ? state.token : null,
        );

        final graphQlDatasource = GraphQlDatasourceImpl(client: client);
        final locationDatasource = LocationDatasourceImpl();
        final imagePickerDatasource = ImagePickerDatasourceImpl();

        final chatRepository = ChatRepositoryImpl(
          graphQlDatasource: graphQlDatasource,
        );
        final privateEventRepository = PrivateEventRepositoryImpl(
          graphQlDatasource: graphQlDatasource,
        );
        final messageRepository = MessageRepositoryImpl(
          graphQlDatasource: graphQlDatasource,
        );
        final userRepository = UserRepositoryImpl(
          graphQlDatasource: graphQlDatasource,
        );
        final locationRepository = LocationRepositoryImpl(
          locationDatasource: locationDatasource,
        );
        final imagePickerRepository = ImagePickerRepositoryImpl(
          imagePickerDatasource: imagePickerDatasource,
        );
        final shoppingListItemRepository = ShoppingListItemRepositoryImpl(
          graphQlDatasource: graphQlDatasource,
        );

        final chatUseCases = ChatUseCases(chatRepository: chatRepository);
        final privateEventUseCases = PrivateEventUseCases(
          privateEventRepository: privateEventRepository,
        );
        final messageUseCases = MessageUseCases(
          messageRepository: messageRepository,
        );
        final userUseCases = UserUseCases(userRepository: userRepository);
        final locationUseCases = LocationUseCases(
          locationRepository: locationRepository,
        );
        final imagePickerUseCases = ImagePickerUseCases(
          imagePickerRepository: imagePickerRepository,
        );
        final shoppingListItemUseCases = ShoppingListItemUseCases(
          shoppingListItemRepository: shoppingListItemRepository,
        );

        final chatCubit = ChatCubit(chatUseCases: chatUseCases);
        final privateEventCubit = PrivateEventCubit(
          privateEventUseCases: privateEventUseCases,
        );

        final userCubit = UserCubit(userUseCases: userUseCases);
        final userSearchCubit = UserSearchCubit(userUseCases: userUseCases);
        final locationCubit = LocationCubit(
          locationUseCases: locationUseCases,
        );
        final homeProfilePageCubit = CurrentUserCubit(
          CurrentUserNormal(
            loadingUser: false,
            user: BlocProvider.of<AuthCubit>(context).state is AuthLoaded
                ? (BlocProvider.of<AuthCubit>(context).state as AuthLoaded)
                        .userResponse ??
                    UserEntity(id: "")
                : UserEntity(id: ""),
          ),
          userUseCases: userUseCases,
        );
        final imageCubit = ImageCubit(
          imagePickerUseCases: imagePickerUseCases,
        );

        final shoppingListCubit = ShoppingListCubit(
          shoppingListItemUseCases: shoppingListItemUseCases,
        );

        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: userCubit),
            BlocProvider.value(value: userSearchCubit),
            BlocProvider.value(value: privateEventCubit),
            BlocProvider.value(value: chatCubit),
            BlocProvider.value(value: homeProfilePageCubit),
            BlocProvider.value(value: locationCubit),
            BlocProvider.value(value: imageCubit),
            BlocProvider.value(value: shoppingListCubit),
          ],
          child: App(
            authState: state,
            appRouter: appRouter,
          ),
        );
      },
    );
  }
}
