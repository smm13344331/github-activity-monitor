import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:github_activity_monitor/model/github_user.dart';

class GithubUsersNotifier extends ChangeNotifier {
  final Map<String, GithubUser> _users = {};

  UnmodifiableMapView<String, GithubUser> get users =>
      UnmodifiableMapView(_users);

  void add(GithubUser user) {
    _users.update(
      user.login,
      (_) => user,
      ifAbsent: () => user,
    );
    notifyListeners();
  }

  void remove(String username) {
    _users.remove(username);
    notifyListeners();
  }

  void removeAll() {
    _users.clear();
    notifyListeners();
  }
}
