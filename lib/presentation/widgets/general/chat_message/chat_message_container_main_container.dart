import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_and_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/location_usecases.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_container_voice_message.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_react_message_container.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/image_fullscreen_dialog.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ionicons/ionicons.dart';

class ChatMessageContainerMainContainer extends StatelessWidget {
  final List<UserEntity> users;
  final MessageEntity message;
  final String currentUserId;
  final MessageEntity? messageToReactTo;
  final bool isCurrentUser;

  const ChatMessageContainerMainContainer({
    super.key,
    required this.currentUserId,
    required this.isCurrentUser,
    required this.message,
    required this.messageToReactTo,
    required this.users,
  });

  UserEntity? findUser(String id) => users.firstWhereOrNull(
        (element) => element.id == id,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isCurrentUser
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.surface,
      ),
      child: Wrap(
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          if (messageToReactTo != null) ...{
            ChatMessageReactMessageContainer(
              messageAndUser: MessageAndUserEntity(
                message: messageToReactTo!,
                user: findUser(
                      messageToReactTo!.createdBy ?? "",
                    ) ??
                    UserEntity(
                      id: "",
                      authId: "",
                    ),
              ),
              currentUserId: currentUserId,
              isInput: false,
            ),
          },
          if (message.fileLinks != null && message.fileLinks!.isNotEmpty) ...[
            //TODO: as list of documents
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 2,
              ),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: InkWell(
                onTap: () => showAnimatedDialog(
                  context: context,
                  curve: Curves.fastOutSlowIn,
                  animationType: DialogTransitionType.slideFromBottomFade,
                  builder: (c) => ImageFullscreenDialog(
                    src: message.fileLinks![0],
                  ),
                ),
                child: Ink(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      message.fileLinks![0],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
          if (message.currentLocation?.geoJson?.coordinates != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 200,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      message.currentLocation!.geoJson!.coordinates![1],
                      message.currentLocation!.geoJson!.coordinates![0],
                    ),
                    zoom: 12,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId("1"),
                      position: LatLng(
                        message.currentLocation!.geoJson!.coordinates![1],
                        message.currentLocation!.geoJson!.coordinates![0],
                      ),
                      icon: BitmapDescriptor.defaultMarker,
                    )
                  },
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => openMaps(
                  context,
                  LatLng(
                    message.currentLocation!.geoJson!.coordinates![1],
                    message.currentLocation!.geoJson!.coordinates![0],
                  ),
                ),
                child: Ink(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(100, 0, 0, 0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Ionicons.map),
                      const SizedBox(width: 16),
                      Text(
                        "In Maps öffnen",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          if (message.currentLocation?.address != null) ...[
            Text(
              "${message.currentLocation!.address?.country}, ${message.currentLocation!.address?.city}, ${message.currentLocation!.address?.zip}, ${message.currentLocation!.address?.street} ${message.currentLocation!.address?.housenumber}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
          if (message.voiceMessageLink != null) ...[
            ChatMessageContainerVoiceMessage(
              voiceMessageLink: message.voiceMessageLink!,
            ),
          ],
          if (message.message != null) ...{
            Text(
              message.message!,
              overflow: TextOverflow.clip,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          },
        ],
      ),
    );
  }

  Future openMaps(BuildContext context, LatLng latLon) async {
    final dz.Either<NotificationAlert, dz.Unit> openedOrFailure =
        await serviceLocator<LocationUseCases>().openMaps(latLng: latLon);

    openedOrFailure.fold(
      (alert) => BlocProvider.of<NotificationCubit>(context).newAlert(
        notificationAlert: alert,
      ),
      (_) => null,
    );
  }
}
