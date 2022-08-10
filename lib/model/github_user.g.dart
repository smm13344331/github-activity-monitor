// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubUser _$GithubUserFromJson(Map<String, dynamic> json) => GithubUser(
      login: json['login'] as String,
      id: json['id'] as int,
      avatarUrl: json['avatar_url'] as String?,
      repositories: (json['repositories'] as List<dynamic>?)
          ?.map((e) => GithubRepository.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GithubUserToJson(GithubUser instance) {
  final val = <String, dynamic>{
    'login': instance.login,
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('avatar_url', instance.avatarUrl);
  writeNotNull(
      'repositories', instance.repositories?.map((e) => e.toJson()).toList());
  return val;
}
