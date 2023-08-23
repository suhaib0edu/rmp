import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlRMP {}

class ConfigGraphQL {
  // static HttpLink httpLink = HttpLink('http://192.168.43.151:8000/graphql/');

  static HttpLink httpLink = HttpLink(
    'http://192.168.43.243:8000/graphql/',
    // defaultHeaders: {
    //   'X-CSRFToken': getCsrfToken(), // Add CSRF token to request headers
    // }
  );
  static AuthLink authLink = AuthLink(
    getToken: () async {
      return null;
    },
  );
  static Link link = authLink.concat(httpLink);

  GraphQLClient gClient() => GraphQLClient(
        link: link,
        cache: GraphQLCache(
          store: HiveStore(),
        ),
        defaultPolicies: DefaultPolicies(
          watchQuery: Policies(
            fetch: FetchPolicy.networkOnly,
            error: ErrorPolicy.all,
          ),
          query: Policies(
            fetch: FetchPolicy.cacheAndNetwork,
            error: ErrorPolicy.all,
          ),
          mutate: Policies(
            fetch: FetchPolicy.networkOnly,
            error: ErrorPolicy.all,
          ),
        ),
      );
}

class GQL {
  static ConfigGraphQL configGraphQL = ConfigGraphQL();
  static GraphQLClient gClient = configGraphQL.gClient();

  static query() {}

  static mutation({
    required String document,
  }) async {
    print('#ConfigGraphQL.httpLink.uri => ${ConfigGraphQL.httpLink.uri}');
    print('#document => $document');
    QueryResult result = await gClient.mutate(MutationOptions(
      document: gql(document),
      // variables: variables,
    ));

  }
}
