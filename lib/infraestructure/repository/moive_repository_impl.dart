
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

}