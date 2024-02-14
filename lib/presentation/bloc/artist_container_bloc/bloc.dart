import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/domain/repositories/get_artist_repository.dart';

import '../../../data/model/album.dart';

class ArtistContainerBloc extends Bloc<ArtistContainerEvent, ArtistContainerState> {

  GetArtistRepository setDateRepository = GetArtistRepository();

  @override
  Stream<ArtistContainerState> mapEventToState(ArtistContainerEvent event) async* {

    if (event is FetchWeatherWithCityNameEvent) {
      yield WeatherLoadingState();
      try {
        final Singer singer = await getArtistRepository.getBestArtist();
        yield WeatherIsLoadedState(weather);
      } catch (exception) {
        if (exception is AppException) {
          yield WeatherError(300);
        } else {
          yield WeatherError(500);
        }
      }
    }

}