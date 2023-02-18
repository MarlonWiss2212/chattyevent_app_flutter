import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql/client.dart';

GraphQLClient getGraphQlClient({String? token}) {
  Link link = HttpLink(
    dotenv.get("API_BASE_URL"),
    defaultHeaders: {
      "Apollo-Require-Preflight": "true",
      "Authorization": "Bearer $token"
    },
  );

  return GraphQLClient(
    link: link,
    cache: GraphQLCache(),
    defaultPolicies: DefaultPolicies(
      query: Policies(fetch: FetchPolicy.noCache),
      mutate: Policies(fetch: FetchPolicy.noCache),
      subscribe: Policies(fetch: FetchPolicy.noCache),
    ),
  );
}
