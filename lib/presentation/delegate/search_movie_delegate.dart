

import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/humans_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';


typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {

    final SearchMovieCallback searchMovie;
     List<Movie> initalMovies;

    StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
    StreamController<bool> isLoadingStream = StreamController.broadcast();
    Timer? _debounceTimer;


    SearchMovieDelegate({required this.initalMovies, required this.searchMovie});

    void _clearStrams(){
      debounceMovies.close();
    }

    void _onQueryChanged( String query){
          isLoadingStream.add(true);
        if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
        _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
          final movie = await searchMovie(query);
          initalMovies = movie;
          debounceMovies.add(movie);
          isLoadingStream.add(false);
        },);
       

    }

    Widget buildResultsAndSuggestios() {
      return StreamBuilder(

      initialData: initalMovies,
      //future: searchMovie(query),
      stream: debounceMovies.stream,
   
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {

          return _MovieSearchItem( movie:movies[index],
          onMovieSelected:(context,movie){
            _clearStrams();
            close(context, movie);

          },);
        });
      },
    );

    }

  @override
  String get searchFieldLabel =>'Buscar Pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    

    return[
      
        StreamBuilder(
          initialData: false,
          stream:isLoadingStream.stream ,
          builder: (context, snapshot) {
            if(snapshot.data!){
              return SpinPerfect(duration:const Duration(milliseconds: 1500) ,spins: 20,infinite: true, child: IconButton(onPressed: () => query ='', icon:const Icon( Icons.refresh_rounded) ));
            }
            return FadeIn(animate: query.isNotEmpty, child: IconButton(onPressed: () => query ='', icon:const Icon( Icons.cleaning_services) ));
           
                        
          },
        )
        //FadeIn(animate: query.isNotEmpty, child: IconButton(onPressed: () => query ='', icon:const Icon( Icons.cleaning_services) ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    
     return IconButton(onPressed: () { 
      _clearStrams();
      close(context,null );}, icon:const Icon( Icons.arrow_back));
    
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestios();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildResultsAndSuggestios();

  }

}

class _MovieSearchItem extends StatelessWidget {

    final Movie movie;
    final Function onMovieSelected;
  const _MovieSearchItem({ required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {

    final texStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return  GestureDetector(
      onTap: () {

        onMovieSelected(context,movie );
        
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Row(
        
          children: [
        
            //Imagen
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network( movie.posterPath),
              ),
            ),
      
            const SizedBox(width: 10,),
      
            //description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(movie.title , style: texStyle.titleMedium,),
                    (movie.overview.length > 50)
                    ? Text( '${movie.overview.substring(0,50)}...')
                    : Text( movie.overview),
      
                    Row(
                      children: [
                        Icon(Icons.star_half_rounded, color: Colors.yellow.shade800,),
                        Text(HumansFormats.number(movie.voteAverage,1), 
                          style: texStyle.bodyMedium!.copyWith(color: Colors.yellow.shade900)
                        )
                      ],
                    )
      
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}