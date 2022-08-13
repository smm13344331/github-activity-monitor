import 'package:github_activity_monitor/model/github_event.dart';
import 'package:github_activity_monitor/repository/github_event_repository.dart';
//import 'package:github_activity_monitor/service_provider.dart';
//import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLGithubEventRepository implements GithubEventRepository {
//  final HttpLink httpLink = HttpLink(
//    'https://api.github.com/graphql',
//  );
//
//  final AuthLink authLink = AuthLink(
//    getToken: () async => 'token ${ServiceProvider.accessToken}',
//    // OR
//    // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
//  );
//
//  late final Link link = authLink.concat(httpLink);

  @override
  Future<List<GithubEvent>> getEventsForUser(String login) {
    String readRepositories = """
  {
    user(login: "$login") {
      contributionsCollection {
        contributionCalendar {
          totalContributions
          weeks {
            contributionDays {
              contributionCount
              weekday
              date
            }
          }
        }
      }
    }
  }
""";
//    final readRepositoriesResult = useQuery(
//      QueryOptions(
//        document:
//            gql(readRepositories), // this is the query string you just created
//        variables: const {
//          'nRepositories': 50,
//        },
//        pollInterval: const Duration(seconds: 10),
//      ),
//    );
//    final result = readRepositoriesResult.result;
//
//    if (result.hasException) {}
//
//    if (result.isLoading) {}
//
//    List? repositories;
//
//    var weeks = result.data?['user']?['contributionsCollection']
//        ?['contributionCalendar']?['weeks'];
//
//    if (repositories == null) {}

    // TODO: implement getEventsForUser
    throw UnimplementedError();
  }
}
