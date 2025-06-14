
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infraestructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infraestructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {

  final dio = Dio(
      BaseOptions(baseUrl:'https://api.themoviedb.org/3',
        queryParameters: {
          'api_key':Environment.movieAppKey,
          'language':'es-MX'
        }));
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async{
  
    final  response = await dio.get('/movie/now_playing');
    final movieDbResponse = MovieDbResponse.fromJson(response.data);
    List<Movie> movies = movieDbResponse.results
    .where((moviedb) => moviedb.posterPath != 'no-poster' )
    .map(
      (moviesdb) => MovieMapper.movieDBToEntitie(moviesdb)
    ).toList();


    return movies;
  }
}