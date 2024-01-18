part of 'weather_bloc.dart';

@immutable
sealed class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  final WeatherModel weatherModel;

  WeatherSuccess({required this.weatherModel});

  @override
  List<Object?> get props => [weatherModel];
}

final class WeatherFailure extends WeatherState {
  final String error;

  WeatherFailure(this.error);

  @override
  List<Object?> get props => [error];
}

final class WeatherLoading extends WeatherState {}
