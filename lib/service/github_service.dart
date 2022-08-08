import 'package:github_activity_monitor/repository/github_event_repository.dart';
import 'package:github_activity_monitor/util/bucket/bucket.dart';

class GithubService{

  late final GithubEventRepository _githubEventRepository;
  static const String pushEvent = "PushEvent";

  GithubService(){
    _githubEventRepository = GithubEventRepository();
  }

  Map<String, List<Bucket>> getUserActivity(String login){
    var events = _githubEventRepository.getEventsForUser(login);
    events.where((event) => event.type == pushEvent).map((e) => null);
    return {};
  }
}
