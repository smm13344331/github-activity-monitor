import 'package:github_activity_monitor/model/github_repository.dart';
import 'package:github_activity_monitor/model/github_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'github_event.g.dart';

/// Simplified version of a github event model
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class GithubEvent {
  late final String id;
  late final String type;
  late final GithubUser? actor;
  late final GithubRepository repo;
  @JsonKey(name: "created_at")
  late final DateTime? createdAt;

  GithubEvent(
      {required this.id,
      required this.type,
      required this.actor,
      required this.repo,
      this.createdAt});

  factory GithubEvent.fromJson(Map<String, dynamic> json) =>
      _$GithubEventFromJson(json);

  Map<String, dynamic> toJson() => _$GithubEventToJson(this);

  @override
  String toString() {
    return 'GithubEvent{id: $id, type: $type, actor: ${actor.toString()}, repo: ${repo.toString()}, createdAt: $createdAt}';
  }
}
