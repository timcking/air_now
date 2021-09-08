import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const _urlBase = 'https://weatherbit-v1-mashape.p.rapidapi.com/current';

class Weather {
  Future<dynamic> getWeather(String lat, String lon) async {
    final response = await http.get(
      Uri.parse('$_urlBase?lat=$lat&lon=$lon&units=imperial'),
      // Send authorization headers to the backend.
      headers: {
        'X-Rapidapi-Key': '6QjwQcW7tTmshOK0H8u3hatQlIk3p1yHkQ2jsnNh0L5YPGI1ix',
        'X-Rapidapi-Host': 'weatherbit-v1-mashape.p.rapidapi.com',
      },
    );

    final responseJson = jsonDecode(response.body);
    return responseJson;
  }
}