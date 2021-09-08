import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

const _urlBase = 'https://air-quality.p.rapidapi.com/current/airquality';

class AirQuality {
  Future<dynamic> getAirQuality(String lat, String lon) async {
    final response = await http.get(
      Uri.parse('$_urlBase?lat=$lat&lon=$lon'),
      // Send authorization headers to the backend.
      headers: {
        'X-Rapidapi-Key': '6QjwQcW7tTmshOK0H8u3hatQlIk3p1yHkQ2jsnNh0L5YPGI1ix',
        'X-Rapidapi-Host': 'air-quality.p.rapidapi.com',
      },
    );

    final responseJson = jsonDecode(response.body);
    return responseJson;
  }

  Color setPollenColor(pollen) {
    Color _pollenColor;
    if (pollen < 1) {
      _pollenColor = Colors.green;
    } else if (pollen < 2) {
      _pollenColor = Colors.yellow;
    } else if (pollen < 3) {
      _pollenColor = Colors.orange;
    } else {
      _pollenColor = Colors.red;
    }
    return _pollenColor;
  }

  String setPollenCondition(pollen) {
    String _condition;
    if (pollen == 0) {
      _condition = 'None';
    } else if (pollen == 1) {
      _condition = 'Low';
    } else if (pollen == 2) {
      _condition = 'Moderate';
    } else if (pollen ==3) {
      _condition = 'High';
    } else {
      _condition = 'Very High';
    }
    return _condition;
  }

  Color setAqiColor(airQuality) {
    Color _aqiColor;
    if (airQuality < 50) {
      _aqiColor = Colors.green;
    } else if (airQuality < 100) {
      _aqiColor = Colors.yellow;
    } else if (airQuality < 150) {
      _aqiColor = Colors.orange;
    } else if (airQuality < 200) {
      _aqiColor = Colors.red;
    } else {
      _aqiColor = Colors.purple;
    }
    return _aqiColor;
  }

  String setAqiCondition(airQuality) {
    String _condition;
    if (airQuality < 50) {
      _condition = 'Good';
    } else if (airQuality < 100) {
      _condition = 'Moderate';
    } else if (airQuality < 150) {
      _condition = 'Unhealthy';
    } else if (airQuality < 200) {
      _condition = 'Very Unhealthy';
    } else {
      _condition = 'Hazardous';
    }

    return _condition;
  }
}