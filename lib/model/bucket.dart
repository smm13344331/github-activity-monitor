import 'package:github_activity_monitor/model/github_event.dart';

/// Bucket the building block of report aggregation system
class Bucket {
  late final dynamic name;
  int? index;

  /// Map of id to github event in this bucket
  late final Map<String, GithubEvent> events = {};

  Bucket(this.name, {this.index});

  Bucket addEvent(GithubEvent event) {
    events.putIfAbsent(event.id, () => event);
    return this;
  }
}
