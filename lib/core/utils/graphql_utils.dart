import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql/client.dart';

class GraphQlUtils {
  static GraphQLClient getGraphQlClient({String? token}) {
    final HttpLink httpLink = HttpLink(
      "https://${dotenv.get("API_BASE_URL")}/graphql",
      defaultHeaders: {
        "Apollo-Require-Preflight": "true",
        "authorization": "Bearer $token"
      },
    );

    final WebSocketLink webSocketLink = WebSocketLink(
      "ws://${dotenv.get("API_BASE_URL")}/graphql",
      subProtocol: GraphQLProtocol.graphqlTransportWs,
      config: SocketClientConfig(
        inactivityTimeout: const Duration(hours: 3),
        autoReconnect: true,
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
}
