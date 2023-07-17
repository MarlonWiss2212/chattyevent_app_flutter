import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/location_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/vibration_usecases.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_react_message_container.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_read_by_bottom_sheet.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/image_fullscreen_dialog.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:latlong2/latlong.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_and_user_entity.dart';

class ChatMessageContainer extends StatefulWidget {
  final List<UserEntity> users;
  final MessageEntity message;
  final String currentUserId;
  final MessageEntity? messageToReactTo;

  const ChatMessageContainer({
    super.key,
    required this.users,
    required this.message,
    required this.currentUserId,
    this.messageToReactTo,
  });

  @override
  State<ChatMessageContainer> createState() => _ChatMessageContainerState();
}

class _ChatMessageContainerState extends State<ChatMessageContainer> {
  double scale = 1;
  UserEntity? findUser(String id) => widget.users.firstWhereOrNull(
        (element) => element.id == id,
      );

  @override
  Widget build(BuildContext context) {
    final UserEntity? foundUser = widget.message.createdBy != null
        ? findUser(widget.message.createdBy!)
        : null;

    final isCurrentUser = foundUser?.id == widget.currentUserId;
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 100),
      child: SwipeTo(
        iconColor: Theme.of(context).colorScheme.onBackground,
        onRightSwipe: () {
          if (foundUser != null) {
            BlocProvider.of<AddMessageCubit>(context).reactToMessage(
              messageToReactToWithUser: MessageAndUserEntity(
                message: widget.message,
                user: foundUser,
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Align(
            alignment:
                isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: isCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (!isCurrentUser) ...[
                  Text(
                    foundUser?.username ?? "",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 4),
                ],
                GestureDetector(
                  onTapDown: (details) async {
                    setState(() {
                      scale = .9;
                    });
                  },
                  onTapUp: (details) => setState(() {
                    scale = 1;
                  }),
                  onTapCancel: () => setState(() {
                    scale = 1;
                  }),
                  onLongPress: () async {
                    await serviceLocator<VibrationUseCases>()
                        .vibrate(duration: 10)
                        .then(
                          (value) async => showModalBottomSheet(
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
                            context: context,
                            builder: (context) {
                              return ChatMessageReadByBottomSheet(
                                users: widget.users,
                                readByIds: widget.message.readBy ?? [],
                              );
                            },
                          ),
                        );
                  },
                  child: data(
                    context,
                    isCurrentUser,
                    isDarkMode,
                  ),
                ),
                const SizedBox(height: 4),
                bottomContainer(context, isCurrentUser, isDarkMode),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget data(
    BuildContext context,
    bool isCurrentUser,
    bool isDarkMode,
  ) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.messageToReactTo != null) ...{
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ChatMessageReactMessageContainer(
                messageAndUser: MessageAndUserEntity(
                  message: widget.messageToReactTo!,
                  user: findUser(
                        widget.messageToReactTo!.createdBy ?? "",
                      ) ??
                      UserEntity(
                        id: "",
                        authId: "",
                      ),
                ),
                currentUserId: widget.currentUserId,
                isInput: false,
              ),
            ),
          },
          if (widget.message.fileLinks != null &&
              widget.message.fileLinks!.isNotEmpty) ...[
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
                    src: widget.message.fileLinks![0],
                  ),
                ),
                child: Ink(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.message.fileLinks![0],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            if (widget.message.message != null ||
                widget.message.currentLocation?.address != null ||
                widget.message.currentLocation?.geoJson?.coordinates !=
                    null) ...{
              const SizedBox(height: 8),
            }
          ],
          if (widget.message.currentLocation?.geoJson?.coordinates != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    FlutterMap(
                      options: MapOptions(
                        interactiveFlags: InteractiveFlag.none,
                        center: LatLng(
                          widget.message.currentLocation!.geoJson!
                              .coordinates![1],
                          widget.message.currentLocation!.geoJson!
                              .coordinates![0],
                        ),
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: LatLng(
                                widget.message.currentLocation!.geoJson!
                                    .coordinates![1],
                                widget.message.currentLocation!.geoJson!
                                    .coordinates![0],
                              ),
                              builder: (context) {
                                return Icon(
                                  Ionicons.location,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Material(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: InkWell(
                            onTap: () => openMaps(
                              LatLng(
                                widget.message.currentLocation!.geoJson!
                                    .coordinates![1],
                                widget.message.currentLocation!.geoJson!
                                    .coordinates![0],
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
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
            if (widget.message.message != null ||
                widget.message.currentLocation?.address != null) ...{
              const SizedBox(height: 8),
            }
          ],
          if (widget.message.currentLocation?.address != null) ...[
            Text(
              "${widget.message.currentLocation!.address?.country}, ${widget.message.currentLocation!.address?.city}, ${widget.message.currentLocation!.address?.zip}, ${widget.message.currentLocation!.address?.street} ${widget.message.currentLocation!.address?.housenumber}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (widget.message.message != null) ...{
              const SizedBox(height: 8),
            }
          ],
          if (widget.message.message != null) ...{
            if (widget.message.fileLinks != null &&
                widget.message.fileLinks!.isNotEmpty) ...{
              const SizedBox(height: 8),
            },
            Text(
              widget.message.message!,
              overflow: TextOverflow.clip,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          },
        ],
      ),
    );
  }

  Future openMaps(LatLng latLon) async {
    final dz.Either<NotificationAlert, dz.Unit> openedOrFailure =
        await serviceLocator<LocationUseCases>().openMaps(LatLng: latLon);

    openedOrFailure.fold(
      (alert) => BlocProvider.of<NotificationCubit>(context).newAlert(
        notificationAlert: alert,
      ),
      (_) => null,
    );
  }

  Widget bottomContainer(
      BuildContext context, bool isCurrentUser, bool isDarkMode) {
    return Row(
      mainAxisAlignment:
          isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Text(
          "${DateFormat.jm().format(widget.message.createdAt)}, ",
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.apply(color: isDarkMode ? Colors.white54 : Colors.black54),
        ),
        const SizedBox(width: 8),
        if (isCurrentUser &&
            widget.message.readBy != null &&
            widget.message.readBy!.isNotEmpty &&
            widget.message.readBy!.length == widget.users.length) ...[
          Stack(
            children: [
              Icon(
                Ionicons.checkmark,
                color: isDarkMode ? Colors.white54 : Colors.black54,
                size: Theme.of(context).textTheme.bodySmall?.fontSize,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Icon(
                  Ionicons.checkmark,
                  color: isDarkMode ? Colors.white54 : Colors.black54,
                  size: Theme.of(context).textTheme.bodySmall?.fontSize,
                ),
              ),
            ],
          ),
        ] else if (isCurrentUser) ...{
          Icon(
            Ionicons.checkmark,
            color: isDarkMode ? Colors.white54 : Colors.black54,
            size: Theme.of(context).textTheme.bodySmall?.fontSize,
          ),
        }
      ],
    );
  }
}
