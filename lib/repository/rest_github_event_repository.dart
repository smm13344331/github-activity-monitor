import 'package:github_activity_monitor/model/github_event.dart';
import 'package:github_activity_monitor/repository/github_event_repository.dart';
import 'package:github_activity_monitor/resources/resources.dart';
import 'package:github_activity_monitor/util/application.dart';
import 'package:github_activity_monitor/util/network_util.dart';

class RestGithubEventRepository implements GithubEventRepository {
  static final RestGithubEventRepository _instance =
      RestGithubEventRepository._internal();

  factory RestGithubEventRepository() => _instance;

  RestGithubEventRepository._internal();

  final NetworkUtil _networkUtil = NetworkUtil();

  @override
  Future<List<GithubEvent>> getEventsForUser(String login) async {
    return _networkUtil
        .GET("${application.network.githubBaseUrl}/users/$login/events/public",
            authenticated: false)
        .then((dynamic result) {
      List<GithubEvent> events = <GithubEvent>[];
      if (result != null) {
        for (var json in result) {
          events.add(GithubEvent.fromJson(json));
        }
      }
      return events;
    });
  }
}
