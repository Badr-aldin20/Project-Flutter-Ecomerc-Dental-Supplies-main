// Utils/Api.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Api {
  static Future<dynamic> get(String url) async {
    return _sendRequest(() => http.get(Uri.parse(url)));
  }

  static Future<dynamic> post(String url, Map<String, dynamic> data) async {
    return _sendRequest(() =>
        http.post(Uri.parse(url), body: jsonEncode(data), headers: _headers));
  }

  static Future<dynamic> put(String url, Map<String, dynamic> data) async {
    return _sendRequest(() =>
        http.put(Uri.parse(url), body: jsonEncode(data), headers: _headers));
  }

  static Future<dynamic> delete(String url) async {
    return _sendRequest(() => http.delete(Uri.parse(url), headers: _headers));
  }

  // Headers for JSON requests
  static Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  // General function for making HTTP requests
  static Future<dynamic> _sendRequest(
      Future<http.Response> Function() request) async {
    try {
      final response = await request();

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Error: ${response.statusCode} - ${response.reasonPhrase}");
        return {
          'error': 'Error ${response.statusCode}: ${response.reasonPhrase}'
        };
      }
    } catch (e) {
      print("Exception: $e");
      return {'error': 'Exception: $e'};
    }
  }


  static postFiles(
    String url,
    Map<String, File> Files,
    Map Date,
  ) async {

    var request = http.MultipartRequest("POST", Uri.parse(url));

    Files.forEach((key, value) async {
      var length = await value.length();
      var stream = http.ByteStream(value.openRead());

      var muitparFile =
          http.MultipartFile(key, stream, length, filename: value.path);
      request.files.add(muitparFile);
    });

    Date.forEach((key, value) {
      request.fields[key] = value;
    });

    var send_Requst = await request.send();
    final response = await http.Response.fromStream(send_Requst);

    if (send_Requst.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Error: ${response.statusCode} - ${response.reasonPhrase}");
    }
  }
}

