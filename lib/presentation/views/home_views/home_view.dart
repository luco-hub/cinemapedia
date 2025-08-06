import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/movies/initial_loading_provider.dart';
import '../../providers/movies/movie_providers.dart';
import '../../providers/movies/movies_slideshow_provider.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMovieProvider.notifier).loadNextPage();
    ref.read(popularMovieProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRateMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final initiaLoading = ref.watch( initialLoadingProvider);

    if ( initiaLoading  ) return const FullScreenLoader();


    final nowPlayingMovies = ref.watch(nowPlayingMovieProvider);
    final popularMovies = ref.watch(popularMovieProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRateMovies = ref.watch(topRateMoviesProvider);
    final slideShowMovies = ref.watch(movieSliderProvider);

    

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title:CustomAppbar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            children: [
              MoviesSlideshow(movies: slideShowMovies),
              MovieHorizontalListview(
                movies: nowPlayingMovies,
                title: 'En cines',
                subTitle: 'Viernes 13',
                loadNextPage: () =>
                    ref.read(nowPlayingMovieProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListview(
                movies: upcomingMovies,
                title: 'Proximamente',
                subTitle: 'Este mes',
                loadNextPage: () =>
                    ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListview(
                movies: popularMovies,
                title: 'Populares',
                loadNextPage: () =>
                    ref.read(popularMovieProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListview(
                movies: topRateMovies,
                title: 'Lo mas Top',
                subTitle: 'Inperdibles',
                loadNextPage: () =>
                    ref.read(topRateMoviesProvider.notifier).loadNextPage(),
              ),
            ],
          );
        }, childCount: 1))
      ],
    );
  }
}
