import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

/// Authentication and user-related functionality.
abstract class AuthRepository {
  /// Saves the current [AuthState] to the storage and <br /><br />
  /// either return a [NotificationAlert] when an error occurred or
  /// returns [Unit] when it worked
  Future<Either<NotificationAlert, Unit>> saveAuthStateToStorage({
    required AuthState state,
  });

  /// Gets the [AuthState] from storage and <br /><br />
  /// either return a [NotificationAlert] when an error occurred or
  /// returns the [AuthState] when the proccess worked
  Either<NotificationAlert, AuthState> getAuthStateFromStorage();

  /// Gets the current Firebase [User] and <br /><br />
  /// either return a [NotificationAlert] when an error occurred or
  /// returns the firebase [User] when the proccess worked
  Either<NotificationAlert, User> getFirebaseUser();

  /// Logs in a user by [email] and [password] and <br /><br />
  /// either return a [NotificationAlert] when an error occurred or
  /// returns the [UserCredential] when the proccess worked
  Future<Either<NotificationAlert, UserCredential>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Registers a new user by [email] and [password] and <br /><br />
  /// either return a [NotificationAlert] when an error occurred or
  /// returns the [UserCredential] when the proccess worked
  Future<Either<NotificationAlert, UserCredential>>
      registerWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Resends the e-mail verification e-mail and <br /><br />
  /// either return a [NotificationAlert] when an error occurred or
  /// returns [Unit] when it worked
  Future<Either<NotificationAlert, Unit>> sendEmailVerification();

  /// Updates the e-mail to the new [newEmail] and <br /><br />
  /// either return a [NotificationAlert] when an error occurred or
  /// returns [Unit] when it worked
  Future<Either<NotificationAlert, Unit>> verifyBeforeUpdateEmail({
    required String newEmail,
  });

  /// Updates the password to the given [newPassword] and <br /><br />
  /// either return a [NotificationAlert] when an error occurred or
  /// returns [Unit] when it worked
  Future<Either<NotificationAlert, Unit>> updatePassword({
    required String newPassword,
  });

  /// Sends a reset password e-mail to the given [email] and <br /><br />
  /// either return a [NotificationAlert] when an error occurred or
  /// returns [Unit] when it worked
  Future<Either<NotificationAlert, Unit>> sendResetPasswordEmail({
    required String email,
  });

  /// Logs out the current Firebase user and <br /><br />
  /// either return a [NotificationAlert] when an error occurred or
  /// returns [Unit] when it worked
  Future<Either<NotificationAlert, Unit>> logout();

  /// Refreshes the Firebase User data and <br /><br />
  /// either return a [NotificationAlert] when an error occurred or
  /// returns new [User] when it worked
  Future<Either<NotificationAlert, User>> refreshUser();

  /// Refreshes the Firebase Token and <br /><br />
  /// either return a [NotificationAlert] when an error occurred or
  /// returns refreshed [String] when it worked
  Future<Either<NotificationAlert, String>> refreshToken({bool? force});

  /// Deletes the Firebase User and <br /><br />
  /// either return a [NotificationAlert] when an error occurred or
  /// returns [Unit] when it worked
  Future<Either<NotificationAlert, Unit>> deleteUser();

  /// Sets the Language for Firebase Auth and <br /><br />
  /// either return a [NotificationAlert] when an error occurred or
  /// returns [Unit] when it worked
  Future<Either<NotificationAlert, Unit>> setLanguageCode({
    required String languageCode,
  });
}
