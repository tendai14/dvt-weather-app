import 'package:bloc/bloc.dart';
import 'package:dvt_weather_app/data/models/current.dart';
import 'package:dvt_weather_app/data/repositories/weather_repository/weather_repository.dart';
import 'package:equatable/equatable.dart';
part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final WeatherRepository weatherRepository;

  CurrentWeatherBloc({required this.weatherRepository})
      : super(CurrentWeatherInitial());

  @override
  Stream<CurrentWeatherState> mapEventToState(
      CurrentWeatherEvent event) async* {}
}
