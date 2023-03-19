part of 'current_weather_bloc.dart';

abstract class CurrentWeatherState extends Equatable {
  const CurrentWeatherState();

  @override
  List<Object> get props => [];
}

class CurrentWeatherInitial extends CurrentWeatherState {}

class CurrentWeatherLoadingState extends CurrentWeatherState {}

class CurrentWeatherLoadedState extends CurrentWeatherState {
  final Current current;

  const CurrentWeatherLoadedState({required this.current});

  @override
  List<Object> get props => [current];
}

class CurrentWeatherErrorState extends CurrentWeatherState {
  final String error;

  const CurrentWeatherErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
