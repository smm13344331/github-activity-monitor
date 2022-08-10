import 'package:github_activity_monitor/configs/dependency_configuration.dart';
import 'package:github_activity_monitor/model/github_event.dart';
import 'package:github_activity_monitor/repository/dummy_github_event_repository.dart';
import 'package:github_activity_monitor/repository/graphql_github_event_repository.dart';
import 'package:github_activity_monitor/repository/rest_github_event_repository.dart';
import 'package:github_activity_monitor/util/application.dart';

abstract class GithubEventRepository {
  Future<List<GithubEvent>> getEventsForUser(String login);

  factory GithubEventRepository() {
    switch (DependencyConfiguration.apiType) {
      case ApiType.rest:
        return RestGithubEventRepository();
      case ApiType.graphQL:
        return GraphQLGithubEventRepository();
      case ApiType.dummy:
        return DummyGithubEventRepository();
    }
  }
}
