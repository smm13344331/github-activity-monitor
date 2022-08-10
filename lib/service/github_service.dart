import 'package:github_activity_monitor/model/bucket.dart';
import 'package:github_activity_monitor/model/bucket_list.dart';
import 'package:github_activity_monitor/model/github_event.dart';
import 'package:github_activity_monitor/model/repository_report.dart';
import 'package:github_activity_monitor/repository/github_event_repository.dart';

class GithubService {
  late final GithubEventRepository _githubEventRepository;
  static const String pushEvent = "PushEvent";

  GithubService() {
    _githubEventRepository = GithubEventRepository();
  }

  Future<List<RepositoryReport>> getUserActivity(String login) async {
    var events = _githubEventRepository.getEventsForUser(login);
    Map<int, RepositoryReport> cache = {};
    return events.then(
      (event) {
        event.where((event) => event.type == pushEvent).forEach(
          (event) {
            updateCache(cache, event, SummaryType.hourOfDay);
            updateCache(cache, event, SummaryType.dayOfWeek);
            updateCache(cache, event, SummaryType.repository);
          },
        );
        return cache.values.toList(growable: false);
      },
    );
  }

  void updateCache(
      Map<int, RepositoryReport> cache, GithubEvent event, SummaryType type) {
    /// Update Cache of current repo
    cache.update(
      event.repo.id,
      (report) {
        /// Update Repository Report for the given summary type
        report.buckets.update(
          type,
          (bucketList) {
            /// Update bucket with the given event
            bucketList.buckets.update(
                getBucketIdBySummaryType(event, type),
                (bucket) => bucket.addEvent(GithubEvent(
                    id: event.id,
                    type: event.type,
                    actor: null,
                    repo: event.repo,
                    createdAt: event.createdAt)),

                /// Create Bucket and add the event to the Bucket if the
                /// Bucket is missing from BucketList
                ifAbsent: () => Bucket(getBucketIdBySummaryType(event, type))
                    .addEvent(GithubEvent(
                        id: event.id,
                        type: event.type,
                        actor: null,
                        repo: event.repo,
                        createdAt: event.createdAt)));
            return bucketList;
          },

          /// Create a BucketList and add subsequent Bucket and event to it
          /// if the BucketList is missing from cache
          ifAbsent: () => BucketList(
            event.repo.id,
            type,
            {
              getBucketIdBySummaryType(event, type):
                  Bucket(getBucketIdBySummaryType(event, type)).addEvent(
                      GithubEvent(
                          id: event.id,
                          type: event.type,
                          actor: null,
                          repo: event.repo,
                          createdAt: event.createdAt)),
            },
          ),
        );
        return report;
      },
      ifAbsent: () => RepositoryReport(
        event.repo,
        event.actor!,
        {
          type: BucketList(
            event.repo.id,
            type,
            {
              getBucketIdBySummaryType(event, type):
                  Bucket(getBucketIdBySummaryType(event, type)).addEvent(
                      GithubEvent(
                          id: event.id,
                          type: event.type,
                          actor: null,
                          repo: event.repo,
                          createdAt: event.createdAt))
            },
          )
        },
      ),
    );
  }

  dynamic getBucketIdBySummaryType(GithubEvent event, SummaryType type) {
    switch (type) {
      case SummaryType.hourOfDay:
        return event.createdAt?.hour;
      case SummaryType.dayOfWeek:
        return event.createdAt?.weekday;
      case SummaryType.repository:
        return event.repo.id;
    }
  }
}
