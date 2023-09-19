import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/usecases/location_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ionicons/ionicons.dart';

class OpenMapsButton extends StatelessWidget {
  final LatLng? latLng;
  final String? query;
  const OpenMapsButton({
    super.key,
    this.latLng,
    this.query,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => openMaps(context),
        child: Ink(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Ionicons.map),
              const SizedBox(width: 16),
              Text(
                "general.openInMapsText",
                style: Theme.of(context).textTheme.labelLarge,
              ).tr(),
            ],
          ),
        ),
      ),
    );
  }

  Future openMaps(BuildContext context) async {
    final Either<NotificationAlert, Unit> openedOrFailure =
        await serviceLocator<LocationUseCases>().openMaps(
      latLng: latLng,
      query: query,
    );

    openedOrFailure.fold(
      (alert) => BlocProvider.of<NotificationCubit>(context).newAlert(
        notificationAlert: alert,
      ),
      (_) => null,
    );
  }
}
