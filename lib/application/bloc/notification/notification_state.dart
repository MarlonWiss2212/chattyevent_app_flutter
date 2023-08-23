part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {
  listenerFunction(BuildContext context);
}

class NotificationInitial extends NotificationState {
  @override
  listenerFunction(BuildContext context) {}
}

class NotificationAlert extends NotificationState {
  final bool snackbar;
  final String title;
  final String message;

  final OperationException? exception;

  @override
  listenerFunction(BuildContext context) async {
    if (snackbar) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 6.0,
          behavior: SnackBarBehavior.floating,
          padding: const EdgeInsets.all(10),
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                message,
                style: Theme.of(context).textTheme.labelMedium,
              )
            ],
          ),
        ),
      );
    } else {
      await showAnimatedDialog(
        curve: Curves.fastEaseInToSlowEaseOut,
        animationType: DialogTransitionType.slideFromBottomFade,
        context: context,
        builder: (c) {
          return CustomAlertDialog(notificationAlert: this, context: c);
        },
      );
    }
  }

  NotificationAlert({
    this.snackbar = false,
    this.exception,
    required this.title,
    required this.message,
  });
}
