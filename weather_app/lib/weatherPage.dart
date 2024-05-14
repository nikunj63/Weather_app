import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';

class weatherPage extends StatefulWidget {
  const weatherPage({super.key});

  @override
  State<weatherPage> createState() => _weatherPageState();
}

class _weatherPageState extends State<weatherPage> {

//api key
final _weatherService = WeatherService('ef4c8484897e30011f5c25e7f8a56a56');
Weather? _weather;

//fetch weather
fetchWeather() async{
  //get the current city
  String CityName = await _weatherService.getCurrentCity();

  //get weather for city
  try{
    final weather = await _weatherService.getWeather(CityName);
    setState(() {
      _weather = weather;
    });
  }
  //any error
  catch(e){
    print(e);
  }
}

//weather animations

//init state
void initState(){
  super.initState();
  // fetch weather on startup
  fetchWeather();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(_weather?.cityName ??"Loading city.."),
            //temperature
            Text('${_weather?.temperature.round()}°C')
          ],
          ),
      ),
    );
  }
}