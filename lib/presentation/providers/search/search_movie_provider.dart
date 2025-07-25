

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchMovieQueryProvider = StateProvider<String>((ref) => '');



final searchdMoviesProvider = StateNotifierProvider<SearchdMoviesNotifier,List<Movie>>((ref) {

  final movieRepository = ref.read(movieRepositoryProvider);

  return SearchdMoviesNotifier(ref: ref,searchMovie:movieRepository.searchMovie );
  
},);

typedef SearchMovieCallback = Future<List<Movie>> Function(String query);


class SearchdMoviesNotifier extends StateNotifier<List<Movie>> {
  
  final SearchMovieCallback searchMovie;
  final Ref ref;

  SearchdMoviesNotifier({
    required this.ref,
    required this.searchMovie
  }):super([]);


  Future<List<Movie>> searchMoviesByQuery(String query) async{

      final List<Movie> movies = await searchMovie(query);
      ref.read(searchMovieQueryProvider.notifier ).update((state) => query,);
      state = movies;

    return movies;
  }

}