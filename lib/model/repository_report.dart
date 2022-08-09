import 'package:github_activity_monitor/model/bucket_list.dart';
import 'package:github_activity_monitor/model/github_repository.dart';

/// Aggregated results for user activity on a repository based on
/// Hour of Day, Day of Week and repository
class RepositoryReport {
  late final GithubRepository repository;

  /// Map of Summary Type to the related buckets
  late final Map<SummaryType, BucketList> buckets;

  RepositoryReport(this.repository, this.buckets);
}
