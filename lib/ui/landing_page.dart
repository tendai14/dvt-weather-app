import 'package:dvt_weather_app/blocs/current_weather_bloc/current_weather_bloc.dart';
import 'package:dvt_weather_app/blocs/weather_forecast_bloc/weather_forecast_bloc.dart';
import 'package:dvt_weather_app/data/models/forecast.dart';
import 'package:dvt_weather_app/helpers/date_converter.dart';
import 'package:dvt_weather_app/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    _callBlocs();
  }

  _callBlocs() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position? position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    BlocProvider.of<CurrentWeatherBloc>(context).add(
      FetchCurrentWeatherEvent(lat: position.latitude, lon: position.longitude),
    );

    BlocProvider.of<WeatherForecastBloc>(context).add(
      FetchWeatherForecastEvent(
          lat: position.latitude, lon: position.longitude),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        BlocConsumer<CurrentWeatherBloc, CurrentWeatherState>(
          listener: (context, state) {
            // ignore: avoid_print
            print(state);
            if (state is CurrentWeatherErrorState) {
              Center(
                child: Text(state.error),
              );
            }
          },
          builder: (context, state) {
            if (state is CurrentWeatherLoadingState) {
              return const Center(
                child: SimpleCircularProgressBar(
                  progressColors: [
                    appColorRainy,
                    appColorSunny,
                    appColorCloudy
                  ],
                ),
              );
            }
            if (state is CurrentWeatherLoadedState) {
              var weatherState =
                  state.current.weather!.map((e) => e.main).toString();
              print(weatherState);
              return Stack(
                children: [
                  weatherState.toString().toLowerCase().contains('clear')
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                            'assets/images/forest_sunny.png',
                            fit: BoxFit.fill,
                          ),
                        )
                      : weatherState.toString().toLowerCase().contains('sunny')
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset(
                                'assets/images/forest_sunny.png',
                                fit: BoxFit.fill,
                              ),
                            )
                          : weatherState
                                  .toString()
                                  .toLowerCase()
                                  .contains('rain')
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.asset(
                                    'assets/images/forest_rainy.png',
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : weatherState
                                      .toString()
                                      .toLowerCase()
                                      .contains('clouds')
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.asset(
                                        'assets/images/forest_cloudy.png',
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : Container(),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Center(
                          child: Text(
                            '${state.current.main?.temp}\u{00B0}',
                            style: const TextStyle(
                                color: appColorWhite, fontSize: 30),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Center(
                          child: Text(
                            weatherState.toString(),
                            style: const TextStyle(
                                color: appColorWhite, fontSize: 30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }

            return const Center(
                child: Text(
              "Oops, Something went wrong",
              style:
                  TextStyle(color: appColorCloudy, fontWeight: FontWeight.bold),
            ));
          },
        ),
        BlocConsumer<CurrentWeatherBloc, CurrentWeatherState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is CurrentWeatherLoadedState) {
              var weatherState =
                  state.current.weather!.map((e) => e.main).first;
              return Container(
                height: 60,
                color: weatherState.toString().toLowerCase().contains('clear')
                    ? appColorSunny
                    : weatherState.toString().toLowerCase().contains('sunny')
                        ? appColorSunny
                        : weatherState.toString().toLowerCase().contains('rain')
                            ? appColorRainy
                            : weatherState
                                    .toString()
                                    .toLowerCase()
                                    .contains('clouds')
                                ? appColorCloudy
                                : appColorWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          '${state.current.main!.tempMin}\u{00B0}',
                          style: const TextStyle(
                              color: appColorWhite, fontSize: 20),
                        ),
                        const Text(
                          'min',
                          style: TextStyle(color: appColorWhite, fontSize: 20),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '${state.current.main!.temp}\u{00B0}',
                          style: const TextStyle(
                              color: appColorWhite, fontSize: 20),
                        ),
                        const Text(
                          'Current',
                          style: TextStyle(color: appColorWhite, fontSize: 20),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '${state.current.main!.temp}\u{00B0}',
                          style: const TextStyle(
                              color: appColorWhite, fontSize: 20),
                        ),
                        const Text(
                          'max',
                          style: TextStyle(color: appColorWhite, fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
        BlocConsumer<WeatherForecastBloc, WeatherForecastState>(
          listener: (context, state) {
            // ignore: avoid_print
            print(state);
          },
          builder: (context, state) {
            if (state is WeatherForecastLoadedState) {
              return _buildForecast(state.forecast);
            }
            return Container();
          },
        )
      ],
    ));
  }
}

Widget _buildForecast(Forecast forecast) {
  return ListView.builder(
    itemCount: forecast.list.length,
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemBuilder: ((context, index) {
      var forecasts = forecast.list[index].weather;
      var weatherState = forecasts.map((element) => element.main);
      return Container(
          color: Colors.blueGrey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                DateConverter.getDayOfTheWeek(forecast.list[index].dtTxt),
                style: const TextStyle(fontSize: 20, color: appColorWhite),
              ),
              weatherState.toString().toLowerCase().contains("clear")
                  ? const ImageIcon(
                      AssetImage("assets/Icons/clear.png"),
                      color: appColorWhite,
                      size: 60,
                    )
                  : weatherState.toString().toLowerCase().contains("rain")
                      ? const ImageIcon(
                          AssetImage("assets/Icons/rain.png"),
                          color: appColorWhite,
                          size: 60,
                        )
                      : weatherState.toString().toLowerCase().contains("clouds")
                          ? const ImageIcon(
                              AssetImage("assets/Icons/partlysunny.png"),
                              color: appColorWhite,
                              size: 60,
                            )
                          : const ImageIcon(
                              AssetImage("assets/Icons/partlysunny.png"),
                              color: appColorWhite,
                              size: 60,
                            ),
              Text(
                '${forecast.list[index].main.temp}\u{00B0}',
                style: const TextStyle(fontSize: 20, color: appColorWhite),
              ),
            ],
          ));
    }),
  );
}
