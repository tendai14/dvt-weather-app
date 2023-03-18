import 'package:dvt_weather_app/app_blocs.dart';
import 'package:dvt_weather_app/app_repositories.dart';
import 'package:dvt_weather_app/ui/landing_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  var config = const AppRepositories(
    appBlocs: AppBlocs(
      app: MyApp(),
    ),
  );

  runApp(config);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather App',
      home: LandingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
