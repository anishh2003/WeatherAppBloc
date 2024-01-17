import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:bloc_test/bloc_test.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late MockWeatherRepository mockWeatherRepository;
  String cityName = "New Delhi";
  WeatherModel weather = WeatherModel(
      currentTemp: 20.0,
      currentSky: 'Rain',
      currentPressure: 10,
      currentWindSpeed: 20.0,
      currentHumidity: 10);

  group('WeatherBloc -', () {
    setUp(() {
      mockWeatherRepository = MockWeatherRepository();
    });

    blocTest(
      'Get weather Success',
      build: () {
        when(() => mockWeatherRepository.getCurrentWeather(cityName))
            .thenAnswer((_) async => weather);

        return WeatherBloc(mockWeatherRepository);
      },
      act: (bloc) => bloc.add(WeatherFetched()),
      expect: () => [
        isA<WeatherLoading>(),
        isA<WeatherSuccess>(),
      ],
    );

    blocTest(
      'Get weather Failure',
      build: () {
        when(() => mockWeatherRepository.getCurrentWeather(cityName))
            .thenThrow(Exception());

        return WeatherBloc(mockWeatherRepository);
      },
      act: (bloc) => bloc.add(WeatherFetched()),
      expect: () => [
        isA<WeatherLoading>(),
        isA<WeatherFailure>(),
      ],
    );
  });
}
