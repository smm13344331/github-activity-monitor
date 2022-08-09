import 'package:github_activity_monitor/model/github_repository.dart';
import 'package:github_activity_monitor/model/github_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'github_event.g.dart';

/// Simplified version of a github event model
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class GithubEvent {
  late final String id;
  late final String type;
  late final GithubUser actor;
  late final GithubRepository repo;
  late final DateTime createdAt;

  GithubEvent(this.id, this.type, this.actor, this.repo, this.createdAt);

  factory GithubEvent.fromJson(Map<String, dynamic> json) =>
      _$GithubEventFromJson(json);

  Map<String, dynamic> toJson() => _$GithubEventToJson(this);

  @override
  String toString() {
    return 'GithubEvent{id: $id, type: $type, actor: $actor, repo: $repo, createdAt: $createdAt}';
  }
}
