import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:clean_coding/data/expection/app_expection.dart';
import 'package:clean_coding/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkServicesApi implements BaseApiServices {
  @override
  Future<dynamic> deleteApi(String url)async {
      dynamic jsonResponse;
    try {
      final response = await http
          .delete(Uri.parse(url))
          .timeout(const Duration(seconds: 50));
      jsonResponse = returnResponse(response);
      if (response.statusCode == 200) {}
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw FetchDataException('Time out try again');
    }
    return jsonResponse;
  }

  @override
  Future<dynamic> getApi(String url) async {
    dynamic jsonResponse;
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 50));
      jsonResponse = returnResponse(response);
      if (response.statusCode == 200) {}
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw FetchDataException('Time out try again');
    }
    return jsonResponse;
  }

  @override
  Future<dynamic> postApi(String url,var data) async {

      dynamic jsonResponse;
    try {
      final response = await http
          .post(Uri.parse(url) ,  body: data)
          .timeout(const Duration(seconds: 50));
      jsonResponse = returnResponse(response);
      if (response.statusCode == 200) {}
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw FetchDataException('Time out try again');
    }
    return jsonResponse;
  }

  dynamic returnResponse(http.Response response) {
    final body = response.body;
    dynamic jsonResponse;

    try {
      jsonResponse = jsonDecode(body);
    } catch (e) {
      throw FetchDataException('Invalid JSON response: $body');
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonResponse;
      case 400:
        throw FetchDataException(
          'Bad request: ${jsonResponse['message'] ?? body}',
        );
      case 401:
        throw UnAuthorizedException('Unauthorized: ${response.statusCode}');
      case 403:
        throw FetchDataException('Forbidden: ${response.statusCode}');
      case 404:
        throw FetchDataException('Not found: ${response.statusCode}');
      case 408:
      case 429:
        throw FetchDataException(
          'Request timeout/rate limited: ${response.statusCode}',
        );
      case 500:
        throw FetchDataException(
          'Internal server error: ${response.statusCode}',
        );
      default:
        throw FetchDataException(
          'Unexpected error ${response.statusCode}: $body',
        );
    }
  }
}
