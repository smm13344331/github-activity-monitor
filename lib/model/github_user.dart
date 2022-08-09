import 'package:github_activity_monitor/model/github_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'github_user.g.dart';

/// Simplified version of a github user model
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class GithubUser {
  late final String login;
  late final int id;
  late final String? avatarUrl;
  late final List<GithubRepository>? repositories;

  GithubUser(
      {required this.login,
      required this.id,
      this.avatarUrl,
      this.repositories});

  factory GithubUser.fromJson(Map<String, dynamic> json) =>
      _$GithubUserFromJson(json);

  Map<String, dynamic> toJson() => _$GithubUserToJson(this);
}
