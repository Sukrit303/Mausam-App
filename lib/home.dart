import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'loading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search_controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    //print("Init state called");
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    //print("Set State called");
  }

  @override
  Widget build(BuildContext context) {
    var city_name = ["Delhi", "Mumbai", "Pune", "Raipur", "Chennai"];
    final _random = new Random();
    String city = city_name[_random.nextInt(city_name.length)];

    Map? info = ModalRoute.of(context)?.settings.arguments as Map?;
    // print(info!['temp_value']);

    String temp = info!['temp_value'];
    String icon = info['icon_value'];
    String getcity = info['city_value'];
    String humidity = info["humidity_value"];
    String desc = info["desc_value"];
    String main = info["main_value"];
    String wind_speed = info["wind_speed_value"];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: NewGradientAppBar(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.blue.shade200],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue.shade800, Colors.blue.shade200]),
            ),
            child: Column(
              children: [
                Container(
                  // Search wala container
                  // color: Colors.grey,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if ((search_controller.text).replaceAll(" ", "") ==
                              "") {
                          } else {
                            Navigator.pushReplacementNamed(context, "/loading",
                                arguments: {
                                  "searchText": search_controller.text,
                                });
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(7, 0, 8, 0),
                          child: const Icon(
                            Icons.search,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          onSubmitted: (value) {
                            if ((value).replaceAll(" ", "") == "") {
                            } else {
                              Navigator.pushReplacementNamed(
                                  context, '/loading',
                                  arguments: {"searchText": value});
                            }
                          },
                          controller: search_controller,
                          enableSuggestions: true,
                          autocorrect: true,
                          decoration: InputDecoration(
                              hintText: "Search $city",
                              border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          children: [
                            Image.network(
                                "http://openweathermap.org/img/wn/$icon@2x.png"),
                            const SizedBox(width: 20),
                            Column(
                              children: [
                                Text(
                                  desc,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "In $getcity",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 230,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(26),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(WeatherIcons.thermometer),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  temp,
                                  style: const TextStyle(
                                    fontSize: 90,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "c",
                                  style: TextStyle(
                                    fontSize: 50,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(26),
                        margin: const EdgeInsets.fromLTRB(24, 0, 10, 0),
                        height: 200,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Icon(WeatherIcons.day_windy),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              wind_speed,
                              style: const TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            const Text("km/h")
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(26),
                        margin: const EdgeInsets.fromLTRB(10, 0, 24, 0),
                        height: 200,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Icon(WeatherIcons.humidity),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              humidity,
                              style: const TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            const Text("Percent")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // const Text("Made with 💙 by Mohan"),
                const Text("Data provided by openweathermap.org"),
                const SizedBox(height: 60)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
