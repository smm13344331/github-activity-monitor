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
    // TODO: this should be ideally be using a real cache infrastructure like Redis
    Map<int, RepositoryReport> cache = {};
    return events.then((value) {
      value.where((event) => event.type == pushEvent).forEach((event) {
        updateCache(cache, event, SummaryType.hourOfDay);
        updateCache(cache, event, SummaryType.dayOfWeek);
        updateCache(cache, event, SummaryType.repository);
      });
      return cache.values.toList(growable: false);
    });
  }

  void updateCache(
      Map<int, RepositoryReport> cache, GithubEvent event, SummaryType type) {
    cache.update(event.repo.id, (report) {
      report.buckets.update(type, (bucketList) {
        bucketList.buckets.update(getBucketIdBySummaryType(event, type),
            (bucket) {
          return bucket.addEvent(event);
        },
            ifAbsent: () =>
                Bucket(getBucketIdBySummaryType(event, type)).addEvent(event));
        return bucketList;
      }, ifAbsent: () {
        return BucketList(event.repo.id, type, {
          getBucketIdBySummaryType(event, type):
              Bucket(getBucketIdBySummaryType(event, type)).addEvent(event)
        });
      });
      return report;
    });
  }

  dynamic getBucketIdBySummaryType(GithubEvent event, SummaryType type) {
    switch (type) {
      case SummaryType.hourOfDay:
        return event.createdAt.hour;
      case SummaryType.dayOfWeek:
        return event.createdAt.weekday;
      case SummaryType.repository:
        return event.repo.id;
    }
  }
}
