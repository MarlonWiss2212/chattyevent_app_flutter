import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/add_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/location/location_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/message/message_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/message/add_message_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/add_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/home_page/home_profile_page/home_profile_page_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/image/image_cubit.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/image_picker_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/location_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/message_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';
import 'package:social_media_app_flutter/infastructure/datasources/device/image_picker.dart';
import 'package:social_media_app_flutter/infastructure/datasources/device/location.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/respositories/chat_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/device/image_picker_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/device/location_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/message_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/private_event_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/user_repository_impl.dart';
import 'package:social_media_app_flutter/injection.dart';
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

    BlocProvider.of<AuthCubit>(context).getTokenAndLoadUser();

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

        final chatCubit = ChatCubit(chatUseCases: chatUseCases);
        final addChatCubit = AddChatCubit(
          chatCubit: chatCubit,
          chatUseCases: chatUseCases,
        );
        final currentChatCubit = CurrentChatCubit(
          chatCubit: chatCubit,
          chatUseCases: chatUseCases,
        );
        final privateEventCubit = PrivateEventCubit(
          privateEventUseCases: privateEventUseCases,
        );
        final addPrivateEventCubit = AddPrivateEventCubit(
          privateEventUseCases: privateEventUseCases,
          privateEventCubit: privateEventCubit,
        );
        final currentPrivateEventCubit = CurrentPrivateEventCubit(
          privateEventUseCases: privateEventUseCases,
          privateEventCubit: privateEventCubit,
        );
        final messageCubit = MessageCubit(messageUseCases: messageUseCases);
        final addMessageCubit = AddMessageCubit(
          messageCubit: messageCubit,
          messageUseCases: messageUseCases,
        );
        final userCubit = UserCubit(userUseCases: userUseCases);
        final userSearchCubit = UserSearchCubit(userUseCases: userUseCases);
        final locationCubit = LocationCubit(
          locationUseCases: locationUseCases,
        );
        final homeProfilePageCubit = HomeProfilePageCubit(
          userUseCases: userUseCases,
        );
        final imageCubit = ImageCubit(
          imagePickerUseCases: imagePickerUseCases,
        );
        final profilePageCubit = ProfilePageCubit(
          userUseCases: userUseCases,
          userCubit: userCubit,
        );

        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: messageCubit),
            BlocProvider.value(value: addMessageCubit),
            BlocProvider.value(value: userCubit),
            BlocProvider.value(value: userSearchCubit),
            BlocProvider.value(value: privateEventCubit),
            BlocProvider.value(value: addPrivateEventCubit),
            BlocProvider.value(value: currentPrivateEventCubit),
            BlocProvider.value(value: chatCubit),
            BlocProvider.value(value: addChatCubit),
            BlocProvider.value(value: currentChatCubit),
            BlocProvider.value(value: homeProfilePageCubit),
            BlocProvider.value(value: locationCubit),
            BlocProvider.value(value: imageCubit),
            BlocProvider.value(value: profilePageCubit),
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
