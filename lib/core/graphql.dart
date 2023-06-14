import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql/client.dart';

GraphQLClient getGraphQlClient({
  String? token,
  bool websocketEndpoint = false,
}) {
  final HttpLink httpLink = HttpLink(
    "http://${dotenv.get("API_BASE_URL")}/graphql",
    defaultHeaders: {
      "Apollo-Require-Preflight": "true",
      "authorization": "Bearer $token"
    },
  );

  final WebSocketLink webSocketLink = WebSocketLink(
    "ws://${dotenv.get("API_BASE_URL")}/graphql",
    subProtocol: GraphQLProtocol.graphqlTransportWs,
    config: SocketClientConfig(
      inactivityTimeout: const Duration(hours: 1),
      autoReconnect: false,
      initialPayload: {
        'authorization': 'Bearer $token',
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
