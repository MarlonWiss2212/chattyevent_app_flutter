part of 'requests_cubit.dart';

class RequestsState {
  final bool loading;
  final List<RequestEntity> requests;
  RequestsState({
    required this.requests,
    required this.loading,
  });
}
