// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubEvent _$GithubEventFromJson(Map<String, dynamic> json) => GithubEvent(
      json['id'] as String,
      json['type'] as String,
      GithubUser.fromJson(json['actor'] as Map<String, dynamic>),
      GithubRepository.fromJson(json['repo'] as Map<String, dynamic>),
      DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$GithubEventToJson(GithubEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'actor': instance.actor.toJson(),
      'repo': instance.repo.toJson(),
      'createdAt': instance.createdAt.toIso8601String(),
    };
