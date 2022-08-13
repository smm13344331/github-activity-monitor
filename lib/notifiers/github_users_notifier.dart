import 'dart:collection';

import 'package:flutter/foundation.dart';

class GithubUsersNotifier extends ChangeNotifier {
  final List<String> _users = [];
  final List<String> _urls = [];

  UnmodifiableListView<String> get users => UnmodifiableListView(_users);
  UnmodifiableListView<String> get urls => UnmodifiableListView(_urls);

  void add(String user, {url = ''}) {
    _users.add(user);
    _urls.add(url);
    notifyListeners();
  }

  int length() => _users.length;

  void removeAt(int index) {
    _users.removeAt(index);
    _urls.removeAt(index);
    notifyListeners();
  }

  void removeAll() {
    _users.clear();
    _urls.clear();
    notifyListeners();
  }

  bool isNotEmpty() => _users.isNotEmpty;

  bool isEmpty() => _users.isEmpty;
}
