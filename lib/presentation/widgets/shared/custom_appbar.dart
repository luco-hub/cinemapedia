import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegate/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_repository_providers.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, ref) {

      final colors = Theme.of(context).colorScheme;
      final styleTitle = Theme.of(context).textTheme.titleMedium;

    return  SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Icon(Icons.movie_outlined, color:colors.primary ,),
                const SizedBox( width: 5,),
                Text('Cinemapedia',style:styleTitle ,),
                const Spacer(),
                IconButton(onPressed: () {
                  final searchMovie = ref.read(searchdMoviesProvider);
                  final searchQuery =ref.watch(searchMovieQueryProvider);

                  showSearch<Movie?>(
                  query: searchQuery,  
                  context: context,
                   delegate: SearchMovieDelegate(
                    initalMovies: searchMovie,
                    searchMovie: ref.read(searchdMoviesProvider.notifier).searchMoviesByQuery 
                   )).then((movie) {
                      if (movie == null) return;
                          context.push('/movie/${movie.id}');
                   });

                }, icon: const Icon(Icons.search))

              ],
            ),
          ),
          ));
  }
}
