import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rmp/index_c.dart';
import 'package:rmp/pages/auth/auth_page.dart';
import 'package:rmp/services/utils.dart';

class GraphQlRMP {}

class ConfigGraphQL {
  // HttpLink httpLink = HttpLink('http://192.168.43.152:8000/graphql/');

  HttpLink httpLink = HttpLink('http://192.168.43.243:8000/graphql/');

  GraphQLClient gClient({required bool withToken}) {
    Link link = AuthLink(
      getToken: () async {
        ConfigDB configD = configDB.getAll().first;
        String? token = configD.token;
        if (withToken && token != null) {
          debugPrint('jwt $token');
          return 'jwt $token';
        }
        return null;
      },
    ).concat(httpLink);

    return GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    );
  }
}

class GQL {
  static ConfigGraphQL configGraphQL = ConfigGraphQL();

  static query() {}

  static mutation({
    required String nMutation,
    required String docVariables,
    required String mResponse,
    required Map<String, dynamic> variables,
    bool withToken = true,
  }) async {
    try {
      GraphQLClient gClient = configGraphQL.gClient(withToken: withToken);
      String xVariables = '';
      String parameters = '';
      Map<String, dynamic> jVariables = mnConvertVariables(docVariables);
      jVariables.forEach((key, value) {
        xVariables = '$xVariables\$$key:$value\n    ';
        parameters = '$parameters$key:\$$key\n    ';
      });
      String document = '''mutation $nMutation(
    $xVariables
    ){
    $nMutation(
    $parameters
    ){
    $mResponse
    }
    }
    ''';
      debugPrint(
          '#ConfigGraphQL.httpLink.uri => ${configGraphQL.httpLink.uri}');
      debugPrint('#document => $document');
      debugPrint('#variables => $variables');
      QueryResult result = await gClient.mutate(MutationOptions(
        document: gql(document),
        variables: variables,
        // variables: variables,
      ));
      if (result.hasException) {
        debugPrint('result.exception=> ${result.exception.toString()}');
        suhErrorIN(
            'GQL=> mutation()result.exception=>', result.exception.toString());
      }

      debugPrint('result.data=>> ${result.data}');
      ConfigDB configD = configDB.getAll().first;
      if (result.data?[nMutation]['token'] != 'null' &&
          result.data?[nMutation]['token'] != null) {
        configD.token = result.data?[nMutation]['token'];
        configDB.put(configD);
      }
      var res = result.data?[nMutation];
      if (res['error']
          .toString()
          .contains('django.contrib.auth.models.AnonymousUser')) {
        configD.isLogin = false;
        configD.token= null;
        configDB.put(configD);
        Get.offAll(() => const AuthPage());
      }

      return res;
    } catch (e) {
      suhErrorIN('GQL=> mutation()', e);
    }
  }

  static Map<String, dynamic> mnConvertVariables(docVariables) {
    Map<String, dynamic> jsonV = {};
    var lines = docVariables.split('\n');
    for (var i = 0; i < lines.length; i++) {
      var line = lines[i].trim();
      if (line != '') {
        var parts = line.split(':');
        var key = parts[0].trim();
        var value = parts[1].trim();
        jsonV['$key'] = '$value';
      }
    }
    return jsonV;
  }
}
