import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_repository_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMovieProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovie = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(fetchMoreMovie: fetchMoreMovie);
});

final popularMovieProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovie = ref.watch(movieRepositoryProvider).getPopular;
  return MoviesNotifier(fetchMoreMovie: fetchMoreMovie);
});
final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovie = ref.watch(movieRepositoryProvider).getUpcoming;
  return MoviesNotifier(fetchMoreMovie: fetchMoreMovie);
});

final topRateMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovie = ref.watch(movieRepositoryProvider).getTopRate;
  return MoviesNotifier(fetchMoreMovie: fetchMoreMovie);
});

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovie;

  MoviesNotifier({required this.fetchMoreMovie}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;
    final List<Movie> movies = await fetchMoreMovie(page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
