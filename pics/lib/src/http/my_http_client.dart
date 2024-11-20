import 'package:http/http.dart' as http;

class MyHttpClient extends http.BaseClient {
  final String userAgent;
  final http.Client _client;

  MyHttpClient(this.userAgent, this._client);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['user-agent'] = userAgent;
    return _client.send(request);
  }
}
