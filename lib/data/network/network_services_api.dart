import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:clean_coding/data/expection/app_expection.dart';
import 'package:clean_coding/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkServicesApi implements BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 50));
      return _handleResponse(response);
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw FetchDataException('Request timed out');
    }
  }

  @override
  Future<dynamic> postApi(String url, dynamic data) async {
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 50));

      return _handleResponse(response);
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw FetchDataException('Request timed out');
    }
  }

  @override
  Future<dynamic> deleteApi(String url) async {
    try {
      final response = await http
          .delete(Uri.parse(url))
          .timeout(const Duration(seconds: 50));
      return _handleResponse(response);
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw FetchDataException('Request timed out');
    }
  }

  dynamic _handleResponse(http.Response response) {
    final body = response.body.replaceAll('\n', '').trim();
    dynamic jsonResponse;

    if (body.isNotEmpty) {
      try {
        jsonResponse = jsonDecode(body);
      } catch (e) {
        throw FetchDataException('Invalid JSON format');
      }
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonResponse ?? {};
      case 400:
        throw FetchDataException(
          (jsonResponse is Map && jsonResponse['message'] != null)
              ? jsonResponse['message'].toString()
              : 'Bad request',
        );
      case 401:
        throw UnAuthorizedException(
          (jsonResponse is Map && jsonResponse['message'] != null)
              ? jsonResponse['message'].toString()
              : 'Unauthorized',
        );
      case 403:
        throw FetchDataException('Forbidden');
      case 404:
        throw FetchDataException('Not found');
      case 500:
        throw FetchDataException('Internal server error');
      default:
        throw FetchDataException(
          'Error ${response.statusCode}: ${response.reasonPhrase ?? ''}',
        );
    }
  }
}
