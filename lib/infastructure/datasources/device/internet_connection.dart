import 'package:connectivity_plus/connectivity_plus.dart';

abstract class InternetConnectionDatasource {
  Stream<ConnectivityResult> internetConnectionStream();
}

class InternetConnectionDatasourceImpl implements InternetConnectionDatasource {
  final Connectivity connectivity;

  InternetConnectionDatasourceImpl({
    required this.connectivity,
  });

  @override
  Stream<ConnectivityResult> internetConnectionStream() {
    return connectivity.onConnectivityChanged;
  }
}
