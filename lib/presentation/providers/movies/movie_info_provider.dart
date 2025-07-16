



import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_repository_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider = StateNotifierProvider<MovieMapNotifier,Map<String,Movie>>((ref){
  
   final moviesRepository = ref.watch(movieRepositoryProvider);
   return MovieMapNotifier(getMovie:moviesRepository.geetMoviById );
});



typedef GetMovieCallback = Future<Movie>Function(String movieId);

class MovieMapNotifier  extends StateNotifier<Map<String,Movie>> {

  final GetMovieCallback getMovie;

  MovieMapNotifier({required this.getMovie}): super({});

  Future<void> loadMovie(String movieId ) async{
    if (state[movieId] != null) return;


    final movie = await getMovie ( movieId);

    state = {...state ,movieId:movie};


  }

}