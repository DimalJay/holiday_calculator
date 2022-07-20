import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:holyday_calculator/domain/api/exceptions.dart';
import 'package:http/http.dart' as http;

class GoogleCalenderApi {
  final String countryCode;
  final String languageCode;

  GoogleCalenderApi({required this.countryCode, required this.languageCode});

  Future<http.Response> _getRequest() async {
    final queryParameters = {
      'key': 'AIzaSyC3T2GIjQus7baGuq8SAfuzZTzE5weIS4Y',
    };

    Uri uri = Uri.https(
        'www.googleapis.com',
        '/calendar/v3/calendars/$languageCode.$countryCode#holiday@group.v.calendar.google.com/events',
        queryParameters);

    return await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
  }

  Future<Map> fetchApi() async {
    http.Response response = await _getRequest();
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw FetchException();
    }
  }
}
