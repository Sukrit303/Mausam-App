import 'package:flutter/material.dart';
import 'api.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late String temp;
  late String humidity;
  late String wind_speed;
  late String desc;
  late String main;
  late String icon;
  String city = 'Raipur';

  void startApp(String city) async {
    Api inst = Api(location: city);
    await inst.getData();
    temp = inst.temp;
    humidity = inst.humidity;
    wind_speed = inst.wind_speed;
    desc = inst.desc;
    main = inst.main;
    icon = inst.icon;

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        "temp_value": temp,
        "humidity_value": humidity,
        "wind_speed_value": wind_speed,
        "desc_value": desc,
        "main_value": main,
        "icon_value": icon,
        "city_value": city,
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

// Map? search = ModalRoute.of(context)?.settings.arguments as Map?;
//     if (search!.isEmpty) {
//       city = search['searchText'];
//     }

  @override
  Widget build(BuildContext context) {
    Map? search = ModalRoute.of(context)?.settings.arguments as Map?;
    if (search?.isNotEmpty ?? false) {
      city = search!['searchText'];
    }
    startApp(city);

    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/mlogo.png",
            height: 240,
            width: 240,
          ),
          const Text(
            "Mausam App",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 15),
          // const Text(
          //   "Made with 💙 by Mohan",
          //   style: TextStyle(
          //     fontSize: 20,
          //   ),
          // ),
          SizedBox(height: 40),
          const SpinKitSpinningLines(
            color: Color.fromARGB(173, 2, 0, 0),
            size: 50.0,
          ),
        ],
      )),
    );
  }
}
