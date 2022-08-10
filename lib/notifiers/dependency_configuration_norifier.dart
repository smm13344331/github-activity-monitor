import 'package:flutter/material.dart';
import 'package:github_activity_monitor/configs/dependency_configuration.dart';
import 'package:github_activity_monitor/util/application.dart';

class DependencyConfigurationNotifier extends ChangeNotifier {
  ApiType get apiType => DependencyConfiguration.apiType;

  void set(ApiType apiType) {
    DependencyConfiguration.apiType = apiType;
    notifyListeners();
  }
}
