import 'dart:convert';
import 'package:http/http.dart';

class Api {
  Api({required this.location}) {
    location = location;
  }
  late String location;
  late String temp;
  late String humidity;
  late String wind_speed;
  late String desc;
  late String main;
  late String icon;

  Future<void> getData() async {
    try {
      Response res = await get(Uri.parse("ENTER YOUR API HERE"));

      Map data = jsonDecode(res.body);

      //
      Map temp_data = data['main'];

      // temperature
      double tmp = temp_data['temp'] - 273.15;
      String getTemp = tmp.toStringAsFixed(1);
      // print(temp);

      // Humidity
      String getHumidity = temp_data["humidity"].toString();
      // print(humidity);

      //Wind speed
      Map map_wind_speed = data["wind"];
      // String getWind_speed = map_wind_speed["speed"].toString();
      double gtWind_speed = map_wind_speed["speed"] * 3.6;
      String getWind_speed = gtWind_speed.toStringAsFixed(1);

      // print(wind_speed);

      List climate = data["weather"];
      Map climat0 = climate[0];
      String getWeather = climat0['main'];
      String getDesc = climat0['description'];
      // print(desc);
      String getIcon = climat0["icon"];

      temp = getTemp;
      humidity = getHumidity;
      wind_speed = getWind_speed;
      desc = getDesc;
      main = getWeather;
      icon = getIcon;
    } catch (e) {
      temp = "NA";
      humidity = "NA";
      wind_speed = "NA";
      desc = "can't find data";
      main = "NA";
      icon = "09d";
    }
  }
}
