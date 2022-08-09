import 'package:github_activity_monitor/model/bucket.dart';

/// Buckets grouped by repository and type in a bucket map with dynamic key type
class BucketList {
  late final int repositoryId;
  late final SummaryType type;

  /// Map of bucket identifier to bucket
  /// identifier is Day of the week or hour of day integer defined by Dart
  /// language in DateTime class. Or a single bucket for counting events
  /// for a repository
  late final Map<dynamic, Bucket> buckets;

  BucketList(this.repositoryId, this.type, this.buckets);
}

enum SummaryType {
  hourOfDay,
  dayOfWeek,
  repository,
}
