import 'package:flutter/material.dart';
import 'package:air_now/location.dart';
import 'package:air_now/aq_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:air_now/air_quality.dart';
import 'package:air_now/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    // This doesn't always work on an emulator
    Location location = Location();
    await location.getCurrentLocation();

    AirQuality aqi = AirQuality();
    var aqiData;
    Weather weather = Weather();
    var weatherData;

    weatherData = await weather.getWeather(
        location.latitude.toString(), location.longitude.toString());

    aqiData = await aqi.getAirQuality(
        location.latitude.toString(), location.longitude.toString());

    // pushReplacement (vs. push) will unload this screen so we don't go back to it
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return AqScreen(
        aqiData: aqiData,
        weatherData: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.purple,
          size: 100.0,
        ),
      ),
    );
  }
}
