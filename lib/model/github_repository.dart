import 'package:json_annotation/json_annotation.dart';

part 'github_repository.g.dart';

/// Simplified version of a github repository model
@JsonSerializable(includeIfNull: false)
class GithubRepository {
  late final int id;
  late final String name;
  late final String url;

  GithubRepository(this.id, this.name, this.url);

  factory GithubRepository.fromJson(Map<String, dynamic> json) =>
      _$GithubRepositoryFromJson(json);

  Map<String, dynamic> toJson() => _$GithubRepositoryToJson(this);

  @override
  String toString() {
    return 'GithubRepository{id: $id, name: $name, url: $url}';
  }


}
