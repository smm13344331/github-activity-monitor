import 'package:flutter/material.dart';
import 'package:github_activity_monitor/configs/routes/route_manager.dart';
import 'package:github_activity_monitor/service/github_service.dart';

class ServiceProvider {
  static bool isInternetAvailable = false;
  static String accessToken = '';

  /// This method checks the JWToken exists or not.
  static bool isJWTokenExist() => accessToken.isNotEmpty;

  /// This method generates a required header for an HTTP request.
  static Map<String, String> generateHeaders({
    bool authenticated = false,
    bool jsonContentType = false,
  }) {
    Map<String, String> headers = <String, String>{};

    if (authenticated) {
      if (isJWTokenExist()) {
        headers.putIfAbsent('Authorization', () => 'token $accessToken');
      }
    }

    String multipartFromData = 'multipart/form-data';
    String jsonEncoded = 'application/json; charset=utf-8';
    headers.putIfAbsent(
      'Content-Type',
      () => jsonContentType ? jsonEncoded : multipartFromData,
    );
    headers.putIfAbsent('Accept', () => 'application/vnd.github+json');
    headers.putIfAbsent('Access-Control-Allow-Origin', () => '*');
    return headers;
  }

  static Future<void> logout(BuildContext context) async {
    accessToken = '';
    RouteManager.navigateTo(
      context: context,
      route: Routes.home,
      clearStack: true,
    );
  }

  static GithubService get githubService => GithubService();
}
