import 'dart:convert';

import 'package:github_activity_monitor/model/bucket.dart';
import 'package:github_activity_monitor/model/bucket_list.dart';
import 'package:github_activity_monitor/model/github_event.dart';
import 'package:github_activity_monitor/model/user_report.dart';
import 'package:github_activity_monitor/repository/github_event_repository.dart';

class GithubService {
  static final GithubService _instance = GithubService._internal();
  static const String pushEvent = "PushEvent";
  late final GithubEventRepository _githubEventRepository;

  factory GithubService() => _instance;

  GithubService._internal() {
    _githubEventRepository = GithubEventRepository();
  }

  Future<UserReport?> getUserActivity(String login) async {
    var events = _githubEventRepository.getEventsForUser(login);
    UserReport? report;
    return events.then(
      (event) {
        event.where((event) => event.type == pushEvent).forEach(
          (event) {
            report ??= UserReport(event.actor!, {});
            updateCache(report!, event, SummaryType.hourOfDay);
            updateCache(report!, event, SummaryType.dayOfWeek);
            updateCache(report!, event, SummaryType.repository);
            updateCache(report!, event, SummaryType.dayOfMonth);
          },
        );
        return report;
      },
    );
  }

  void updateCache(UserReport report, GithubEvent event, SummaryType type) {
    /// Update Report for the given summary type
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
  }
}

dynamic getBucketIdBySummaryType(GithubEvent event, SummaryType type) {
  switch (type) {
    case SummaryType.hourOfDay:
      return event.createdAt?.hour;
    case SummaryType.dayOfWeek:
      return event.createdAt?.weekday;
    case SummaryType.repository:
      return event.repo.id;
    case SummaryType.dayOfMonth:
      return event.createdAt?.day;
  }
}
