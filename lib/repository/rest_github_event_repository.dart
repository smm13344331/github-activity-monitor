import 'package:github_activity_monitor/model/github_event.dart';
import 'package:github_activity_monitor/repository/github_event_repository.dart';

class RestGithubEventRepository implements GithubEventRepository{
  static final RestGithubEventRepository _instance =
      RestGithubEventRepository._internal();

  factory RestGithubEventRepository() => _instance;

  RestGithubEventRepository._internal();

  @override
  List<GithubEvent> getEventsForUser(String login) {

    // TODO: implement getEventsForUser
    throw UnimplementedError();
  }

}