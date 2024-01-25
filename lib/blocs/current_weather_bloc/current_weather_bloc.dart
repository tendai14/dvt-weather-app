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
      : super(CurrentWeatherInitial()) {
    on<CurrentWeatherEvent>((event, emit) async {
      if (event is FetchCurrentWeatherEvent) {
        emit(CurrentWeatherLoadingState());

        try {
          var data = await weatherRepository.getCurrentWeatherCondition(
              event.lat, event.lon);

          // ignore: avoid_print
          print("***Loaded");
          // ignore: avoid_print
          print(data);

          emit(CurrentWeatherLoadedState(current: data));
        } catch (e) {
          emit(CurrentWeatherErrorState(error: e.toString()));
        }
      }
    });
  }

  // @override
  // Stream<CurrentWeatherState> mapEventToState(
  //     CurrentWeatherEvent event) async* {
  //   // ignore: avoid_print
  //   print("in current weather bloc");

  //   if (event is FetchCurrentWeatherEvent) {
  //     try {
  //       yield CurrentWeatherLoadingState();
  //       var data = await weatherRepository.getCurrentWeatherCondition(
  //           event.lat, event.lon);

  //       // ignore: avoid_print
  //       print("***Loaded");
  //       // ignore: avoid_print
  //       print(data);

  //       yield CurrentWeatherLoadedState(current: data);
  //     } catch (e) {
  //       yield CurrentWeatherErrorState(error: e.toString());
  //     }
  //   }
  // }
}
