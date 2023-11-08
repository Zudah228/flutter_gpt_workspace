sealed class HttpResponseBase<T extends Object?> {
  const HttpResponseBase({
    required this.method,
    required this.url,
    required this.headers,
    required this.statusCode,
  });

  final String method;
  final Uri url;
  final Map<String, String> headers;
  final int statusCode;

  T get body => throw UnsupportedError('Body が存在しません');

  bool get isInformationStatus => 100 <= statusCode && statusCode < 200;
  bool get isSuccessStatus => 200 <= statusCode && statusCode < 300;
  bool get isRedirectStatus => 300 <= statusCode && statusCode < 400;
  bool get isClientErrorStatus => 400 <= statusCode && statusCode < 500;
  bool get isServerStatus => 500 <= statusCode && statusCode < 600;
}

class HttpResponse<T> extends HttpResponseBase<T> {
  const HttpResponse({
    required super.method,
    required super.url,
    required super.headers,
    required super.statusCode,
  });
}

class HttpResponseWithJson<T extends Object?> extends HttpResponseBase<T> {
  const HttpResponseWithJson({
    required super.method,
    required super.url,
    required super.headers,
    required super.statusCode,
    required T body,
  }) : _body = body;

  final T _body;

  @override
  T get body => _body;
}
