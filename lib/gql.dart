import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql/client.dart';
import '../injection.dart' as di;

Future<void> resetDiWithNewGraphQlLink(String token) async {
  final HttpLink httpLink = HttpLink(dotenv.get("API_BASE_URL"));
  final AuthLink authLink = AuthLink(
    getToken: () => "Bearer $token",
  );
  await di.serviceLocator.reset();
  await di.init(link: authLink.concat(httpLink));
}
