import 'package:github_activity_monitor/model/github_event.dart';
import 'package:github_activity_monitor/repository/github_event_repository.dart';
import 'package:github_activity_monitor/util/application.dart';
import 'package:github_activity_monitor/util/network_util.dart';

class RestGithubEventRepository implements GithubEventRepository {
  static final RestGithubEventRepository _instance =
      RestGithubEventRepository._internal();

  factory RestGithubEventRepository() => _instance;

  RestGithubEventRepository._internal();

  final NetworkUtil _networkUtil = NetworkUtil();

  @override
  Future<List<GithubEvent>> getEventsForUser(String login,
      {int page = 1}) async {
    try {
      return _networkUtil
          .GET(
              "${application.network.githubBaseUrl}/users/$login/events/public?per_page=100&page=$page",
              authenticated: true)
          .then((dynamic result) async {
        List<GithubEvent> events = <GithubEvent>[];
        if (result != null && result.isNotEmpty && result[0]["error"] == null) {
          await getEventsForUser(login, page: page + 1)
              .then((value) => events.addAll(value));
          for (var json in result) {
            events.add(GithubEvent.fromJson(json));
          }
        }
        return events;
      });
    } catch (_) {
      return Future<List<GithubEvent>>(
        () => <GithubEvent>[],
      );
    }
  }
}
