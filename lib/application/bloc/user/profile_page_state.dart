part of 'profile_page_cubit.dart';

@immutable
abstract class ProfilePageState {}

class ProfilePageInitial extends ProfilePageState {}

class ProfilePageLoading extends ProfilePageState {}

class ProfilePageEditing extends ProfilePageState {}

class ProfilePageError extends ProfilePageState {
  final String title;
  final String message;
  ProfilePageError({required this.title, required this.message});
}

class ProfilePageLoaded extends ProfilePageState {}
