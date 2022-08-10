// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubEvent _$GithubEventFromJson(Map<String, dynamic> json) => GithubEvent(
      id: json['id'] as String,
      type: json['type'] as String,
      actor: json['actor'] == null
          ? null
          : GithubUser.fromJson(json['actor'] as Map<String, dynamic>),
      repo: GithubRepository.fromJson(json['repo'] as Map<String, dynamic>),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$GithubEventToJson(GithubEvent instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'type': instance.type,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('actor', instance.actor?.toJson());
  val['repo'] = instance.repo.toJson();
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  return val;
}
