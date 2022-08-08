import 'package:github_activity_monitor/model/github_event.dart';
import 'package:github_activity_monitor/repository/graphql_github_event_repository.dart';
import 'package:github_activity_monitor/repository/rest_github_event_repository.dart';
import 'package:github_activity_monitor/util/application.dart';

abstract class GithubEventRepository {
  List<GithubEvent> getEventsForUser(String login);

  factory GithubEventRepository() {
    switch (application.apiType) {
      case ApiType.rest:
        return RestGithubEventRepository();
      case ApiType.graphQL:
        return GraphQLGithubEventRepository();
    }
  }
}
