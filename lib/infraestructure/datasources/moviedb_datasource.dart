
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infraestructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infraestructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infraestructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {

  final dio = Dio(
      BaseOptions(baseUrl:'https://api.themoviedb.org/3',
        queryParameters: {
          'api_key':Environment.movieAppKey,
          'language':'es-MX'
        }));

    List<Movie> _jsonToMovies(Map<String,dynamic> json){

      final movieDbResponse = MovieDbResponse.fromJson(json);
    List<Movie> movies = movieDbResponse.results
    .where((moviedb) => moviedb.posterPath != 'no-poster' )
    .map(
      (moviesdb) => MovieMapper.movieDBToEntitie(moviesdb)
    ).toList();

    return movies;


    }


  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async{
  
    final  response = await dio.get('/movie/now_playing', queryParameters: {
      'page':page
    });
    
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async{
    final  response = await dio.get('/movie/popular', queryParameters: {
      'page':page
    });
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getTopRate({int page = 1}) async {
    final  response = await dio.get('/movie/top_rated', queryParameters: {
      'page':page
    });
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
  final  response = await dio.get('/movie/upcoming', queryParameters: {
      'page':page
    });
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<Movie> geetMoviById(String id) async {
     
    final  response = await dio.get('/movie/$id');
    if ( response.statusCode != 200 ) throw Exception('Movie whit id: $id not found');

    final movieDetails = MovieDetails.fromJson( response.data );

    final Movie movie = MovieMapper.movieDetalsToEntity(movieDetails);


    return movie;
   
  }
}