import 'package:bloc/bloc.dart';
import 'package:dvt_weather_app/data/models/forecast.dart';
import 'package:dvt_weather_app/data/repositories/weather_repository/weather_repository.dart';
import 'package:equatable/equatable.dart';
part 'weather_forecast_event.dart';
part 'weather_forecast_state.dart';

class WeatherForecastBloc
    extends Bloc<WeatherForecastEvent, WeatherForecastState> {
  final WeatherRepository weatherRepository;
  WeatherForecastBloc({required this.weatherRepository})
      : super(WeatherForecastInitial());

  @override
  Stream<WeatherForecastState> mapEventToState(
      WeatherForecastEvent event) async* {
    // ignore: avoid_print
    print("in forecast weather bloc");

    if (event is FetchWeatherForecastEvent) {
      try {
        yield WeatherForecastLoadingState();
        var data =
            await weatherRepository.getWeatherForecast(event.lat, event.lon);
        // ignore: avoid_print
        print("***Loaded");
        // ignore: avoid_print
        print(data);
        yield WeatherForecastLoadedState(forecast: data);
      } catch (e) {
        yield WeatherForecastErrorState(error: e.toString());
      }
    }
  }
}
