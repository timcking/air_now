import 'package:flutter/material.dart';
import 'package:air_now/air_quality.dart';
import 'package:air_now/weather.dart';

class AqScreen extends StatefulWidget {
  AqScreen({
    this.aqiData,
    this.weatherData,
  });

  final aqiData;
  final weatherData;

  @override
  _AqScreenState createState() => _AqScreenState();
}

class _AqScreenState extends State<AqScreen> {
  final double labelFont = 22;
  final double dataFont = 20;
  final double qualityFont = 16;
  final double titleFont = 28;

  late String city = '';
  late String state = '';
  late String weatherIcon = 'c02d';
  late int temperature = 0;

  var listHeadings = ['Air Quality', 'Mold', 'Tree', 'Grass', 'Ragweed'];

  var listScore = [];
  var listCondition = [];
  var listColor = [];

  @override
  void initState() {
    super.initState();
    _getAQI();
  }

  void _getAQI() async {
    Weather weather = Weather();
    AirQuality aqi = AirQuality();
    var score;
    var pollenList = [
      'mold_level',
      'pollen_level_tree',
      'pollen_level_grass',
      'pollen_level_weed'
    ];

    setState(() {
      double temp = widget.weatherData['data'][0]['temp'];
      temperature = temp.toInt();

      weatherIcon = widget.weatherData['data'][0]['weather']['icon'];

      city = widget.weatherData['data'][0]['city_name'] + ', ';
      state = widget.weatherData['data'][0]['state_code'];

      score = widget.aqiData['data'][0]['aqi'];
      listScore.add(score);
      listColor.add(aqi.setAqiColor(score));
      listCondition.add(aqi.setAqiCondition(score));

      // Can loop through the rest
      pollenList.forEach((element) {
        score = widget.aqiData['data'][0][element];
        listScore.add(score);
        listColor.add(aqi.setPollenColor(score));
        listCondition.add(aqi.setPollenCondition(score));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      backgroundColor: Colors.indigo,
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$temperature° F',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Source Sans Pro',
                    fontSize: titleFont),
              ),
              Image.asset('assets/images/$weatherIcon.png'),
            ],
          ),
          SizedBox(height: 5.0),
          Text(
            '$city$state',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Source Sans Pro',
                fontStyle: FontStyle.italic,
                fontSize: titleFont),
          ),
          SizedBox(height: 5.0),
          Expanded(
              child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: listHeadings.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: const EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                tileColor: Colors.lightBlueAccent,
                trailing: MaterialButton(
                  color: listColor[index],
                  shape: CircleBorder(),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      listScore[index].toString(),
                      style: TextStyle(color: Colors.black, fontSize: dataFont),
                    ),
                  ),
                ),
                title: Text(listHeadings[index],
                    style: TextStyle(color: Colors.black, fontSize: labelFont)),
                subtitle: Text(
                  listCondition[index],
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Source Sans Pro',
                    fontSize: qualityFont,
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          )),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getAQI,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
