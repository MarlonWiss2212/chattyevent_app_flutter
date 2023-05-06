import 'package:http/http.dart' as http;

abstract class HttpDatasource {
  Future<http.Response> get({required String url});
}

class HttpDatasourceImpl extends HttpDatasource {
  @override
  Future<http.Response> get({required String url}) async {
    return await http.get(Uri.parse("https://$url"));
  }
}
