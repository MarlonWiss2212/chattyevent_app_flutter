import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql/client.dart';

GraphQLClient getGraphQlClient({String? token}) {
  HttpLink link = HttpLink(
    dotenv.get("API_BASE_URL"),
    defaultHeaders: {
      "Apollo-Require-Preflight": "true",
      "Authorization": "Bearer $token"
    },
  );
  WebSocketLink wsLink = WebSocketLink(
    "ws://${"API_BASE_URL".split('//')[1]}",
    config: SocketClientConfig(
      headers: {
        "Authorization": "Bearer $token",
      },
    ),
  );

  return GraphQLClient(
    link: link.split((request) => request.isSubscription, wsLink, link),
    cache: GraphQLCache(),
    defaultPolicies: DefaultPolicies(
      query: Policies(fetch: FetchPolicy.noCache),
      mutate: Policies(fetch: FetchPolicy.noCache),
      subscribe: Policies(fetch: FetchPolicy.noCache),
    ),
  );
}
