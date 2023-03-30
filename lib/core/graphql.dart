import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql/client.dart';

GraphQLClient getGraphQlClient({
  String? token,
  bool websocketEndpoint = false,
}) {
  final HttpLink httpLink = HttpLink(
    "https://${dotenv.get("API_BASE_URL")}",
    defaultHeaders: {
      "Apollo-Require-Preflight": "true",
      "authorization": "Bearer $token"
    },
  );
  final WebSocketLink webSocketLink = WebSocketLink(
    "wss://${dotenv.get("API_BASE_URL")}",
    subProtocol: GraphQLProtocol.graphqlWs,
    config: SocketClientConfig(
      inactivityTimeout: const Duration(hours: 1),
      initialPayload: {
        "authorization": "Bearer $token",
      },
    ),
  );

  return GraphQLClient(
    link: Link.split(
      (request) => request.isSubscription,
      webSocketLink,
      httpLink,
    ),
    cache: GraphQLCache(),
    defaultPolicies: DefaultPolicies(
      query: Policies(fetch: FetchPolicy.noCache),
      mutate: Policies(fetch: FetchPolicy.noCache),
      subscribe: Policies(fetch: FetchPolicy.noCache),
    ),
  );
}
