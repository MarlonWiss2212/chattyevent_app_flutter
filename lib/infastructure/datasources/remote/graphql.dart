import 'package:graphql/client.dart';

abstract class GraphQlDatasource {
  Future<QueryResult<Object?>> query(String options,
      {Map<String, dynamic> variables = const {}});
  Future<QueryResult<Object?>> mutation(String options,
      {Map<String, dynamic> variables = const {}});

  Stream<QueryResult<Object?>> subscription(String options,
      {Map<String, dynamic> variables = const {}});
}

class GraphQlDatasourceImpl implements GraphQlDatasource {
  final GraphQLClient client;
  GraphQlDatasourceImpl({required this.client});

  @override
  Future<QueryResult<Object?>> query(String options,
      {Map<String, dynamic> variables = const {}}) {
    return client.query(
      QueryOptions(
        document: gql(options),
        variables: variables,
      ),
    );
  }

  @override
  Future<QueryResult<Object?>> mutation(String options,
      {Map<String, dynamic> variables = const {}}) {
    return client.mutate(
      MutationOptions(
        document: gql(options),
        variables: variables,
      ),
    );
  }

  @override
  Stream<QueryResult<Object?>> subscription(String options,
      {Map<String, dynamic> variables = const {}}) {
    return client.subscribe(
      SubscriptionOptions(
        document: gql(options),
        variables: variables,
      ),
    );
  }
}
