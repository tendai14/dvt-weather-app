part of 'weather_forecast_bloc.dart';

abstract class WeatherForecastState extends Equatable {
  const WeatherForecastState();

  @override
  List<Object> get props => [];
}

class WeatherForecastInitial extends WeatherForecastState {}

class WeatherForecastLoadingState extends WeatherForecastState {}

class WeatherForecastLoadedState extends WeatherForecastState {
  final Forecast forecast;

  const WeatherForecastLoadedState({required this.forecast});

  @override
  List<Object> get props => [forecast];
}

class WeatherForecastErrorState extends WeatherForecastState {
  final String error;

  const WeatherForecastErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
