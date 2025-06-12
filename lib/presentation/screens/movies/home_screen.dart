import 'package:cinemapedia/presentation/providers/movies/movie_providers.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const nameRouter = "home-screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView({
    super.key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMovieProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMovieProvider);
    return Column(
      children: [
        const CustomAppbar(),
        Expanded(
            child: ListView.builder(
          itemCount: nowPlayingMovies.length,
          itemBuilder: (context, index) {
            final movie = nowPlayingMovies[index];

            return ListTile(
              title: Text(
                movie.title,
              ),
            );
          },
        ))
      ],
    );
  }
}
