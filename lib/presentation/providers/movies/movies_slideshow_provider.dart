



import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieSliderProvider = Provider<List<Movie>>((ref){


    final nowPlayingMovies = ref.watch( nowPlayingMovieProvider);

    if ( nowPlayingMovies.isEmpty ) return [];

    return nowPlayingMovies.sublist(0,6);


});