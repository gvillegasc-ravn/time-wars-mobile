import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:timestart/domain/models/time_entries.dart';

class RequestType {
  static const String get = 'get';
  static const String post = 'post';
  static const String patch = 'patch';
}

class RemoteDataSourceImpl {
  RemoteDataSourceImpl({
    required this.client,
  });

  final http.Client client;

  Future<TimeEntries> getTimeEntries() async {
    final resp = await _apiRequest('/api/v1/time-entries/get-all');
    if (resp.statusCode == 200) {
      final timeEntries = timeEntriesFromJson(resp.body);
      return timeEntries;
    } else {
      throw Exception();
    }
  }

  Future<dynamic> _apiRequest(String endpoint,
      {String type = RequestType.get}) async {
    const baseUrl = 'faithful-literate-chigger.ngrok-free.app';

    final headers = {
      'Content-Type': 'application/json',
    };

    final url = Uri.https(baseUrl, endpoint);

    Response resp;

    switch (type) {
      case RequestType.get:
        resp = await http.get(url, headers: headers);
        return resp;
      default:
        resp = await http.get(url, headers: headers);
        return resp;
    }
  }
}
