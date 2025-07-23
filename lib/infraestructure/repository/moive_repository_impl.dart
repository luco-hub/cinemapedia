
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/infraestructure/datasources/moviedb_datasource.dart';

class MoiveRepositoryImpl extends MoviesRepository {

  final MoviedbDatasource datasource;
  MoiveRepositoryImpl({required this.datasource});

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
   
   return datasource.getPopular(page: page);
  }
  
  @override
  Future<List<Movie>> getTopRate({int page = 1}) {
    return datasource.getTopRate(page: page);
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
   return datasource.getUpcoming(page: page);
  }
  
  @override
  Future<Movie> geetMoviById(String id) {

    return datasource.geetMoviById(id);
  }
  
  @override
  Future<List<Movie>> searchMovie(String query) {
    return   datasource.searchMovie(query);
  }

}