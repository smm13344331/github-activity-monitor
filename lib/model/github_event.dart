import 'package:github_activity_monitor/model/github_repository.dart';
import 'package:github_activity_monitor/model/github_user.dart';

class GithubEvent {
  late final String id;
  late final String type;
  late final GithubUser actor;
  late final GithubRepository repo;
  late final String createdAt;
}

