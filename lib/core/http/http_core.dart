import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'http_response.dart';

class HttpCore {
  const HttpCore(this._client);

  final Client _client;

  Future<HttpResponseBase<T>> get<T extends Object?>(
    Uri url, {
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromBody,
    ContentType? contentType,
  }) async {
    return _run<T>(
      () => _client.get(url, headers: headers),
      fromBody: fromBody,
    );
  }

  Future<HttpResponseBase<T>> post<T extends Object?>(
    Uri url, {
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromBody,
    ContentType? contentType,
    Object? body,
  }) async {
    return _run<T>(
      () => _client.post(url, body: body, headers: headers),
      fromBody: fromBody,
    );
  }

  Future<HttpResponseBase<T>> patch<T extends Object?>(
    Uri url, {
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromBody,
    Object? body,
  }) async {
    return _run<T>(
      () => _client.patch(url, body: body, headers: headers),
      fromBody: fromBody,
    );
  }

  Future<HttpResponseBase<T>> delete<T extends Object?>(
    Uri url, {
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromBody,
    Object? body,
  }) async {
    return _run<T>(
      () => _client.delete(url, body: body, headers: headers),
      fromBody: fromBody,
    );
  }

  Future<HttpResponseBase<T>> _run<T extends Object?>(
    Future<Response> Function() handler, {
    required T Function(Map<String, dynamic>)? fromBody,
  }) async {
    try {
      final response = await handler();

      if (fromBody != null) {
        return HttpResponseWithJson<T>(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url,
          statusCode: response.statusCode,
          body: fromBody(jsonDecode(response.body) as Map<String, dynamic>),
        );
      } else {
        return HttpResponse<T>(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url,
          statusCode: response.statusCode,
        );
      }
    } catch (e, s) {
      debugPrintStack(label: e.toString(), stackTrace: s);

      rethrow;
    }
  }
}
