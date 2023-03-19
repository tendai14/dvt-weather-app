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
      WeatherForecastEvent event) async* {}
}
