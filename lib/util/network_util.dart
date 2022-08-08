import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:github_activity_monitor/rest_provider.dart';
import 'package:github_activity_monitor/util/application.dart';
import 'package:http/http.dart';

typedef OnUploadProgressCallback = void Function(int sentBytes, int totalBytes);

class NetworkUtil {
  static NetworkUtil instance = NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => instance;

  static JsonDecoder get decoder => const JsonDecoder();

  static JsonEncoder get encoder => const JsonEncoder();

  /// POST Method

  // ignore: non_constant_identifier_names
  Future<dynamic> POST(
    String url, {
    bool authenticated = true,
    bool jsonContentType = true,
    body,
    encoding,
    Format format = Format.json,
    bool forceAuthenticate = false,
  }) async {
    application.logger.i('======>  POST URL: $url');
    var headers = RestProvider.generateHeaders(
      authenticated: authenticated,
      jsonContentType: jsonContentType,
    );
    Response response;
    Uri uri = Uri.parse(url);
    response = await post(
      uri,
      body: body,
      headers: headers,
      encoding: encoding ?? Encoding.getByName('utf-8'),
    );
    final String res = response.body;
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400) {
      application.logger.e(res);
    }

    switch (format) {
      case Format.json:
        return decoder.convert(utf8.decode(response.bodyBytes));
      case Format.string:
        return res;
    }
  }

  /// GET Method
  // ignore: non_constant_identifier_names
  Future<dynamic> GET(
    String url, {
    bool authenticated = false,
    bool jsonContentType = true,
    Format format = Format.json,
  }) async {
    application.logger.i('======>  GET URL: $url');
    Response response;
    String body;
    var headers = RestProvider.generateHeaders(
      authenticated: authenticated,
      jsonContentType: jsonContentType,
    );
    Uri uri = Uri.parse(url);
    response = await get(uri, headers: headers);

    int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400) {
      application.logger.e("Request returned with error: ${response.body}");
      return response.body;
    }
    body = utf8.decode(response.bodyBytes);

    switch (format) {
      case Format.json:
        return decoder.convert(body);
      case Format.string:
        return body;
    }
  }

  static Future<bool?> isInternetAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        application.logger.i('Internet connection status: connected');
        return true;
      }
    } on SocketException catch (_) {
      application.logger.e('Internet connection status: not connected');
      return false;
    }
    return null;
  }
}

enum Format { string, json }
