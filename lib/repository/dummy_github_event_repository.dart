import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:github_activity_monitor/model/github_event.dart';
import 'package:github_activity_monitor/repository/github_event_repository.dart';

class DummyGithubEventRepository implements GithubEventRepository {
  static final DummyGithubEventRepository _instance =
      DummyGithubEventRepository._internal();

  factory DummyGithubEventRepository() => _instance;

  DummyGithubEventRepository._internal();

  @override
  Future<List<GithubEvent>> getEventsForUser(String login) async {
    var result = json.decode(await loadAsset());
    List<GithubEvent> events = <GithubEvent>[];
    for (var json in result) {
      events.add(GithubEvent.fromJson(json));
    }
    return events;
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('data/dummy-data.json');
  }
}
