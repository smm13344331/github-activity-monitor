import 'package:github_activity_monitor/model/github_event.dart';
import 'package:github_activity_monitor/repository/github_event_repository.dart';

class GraphQLGithubEventRepository implements GithubEventRepository {
  @override
  Future<List<GithubEvent>> getEventsForUser(String login) {
    // TODO: implement getEventsForUser
    throw UnimplementedError();
  }
}
