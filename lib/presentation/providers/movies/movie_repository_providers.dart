
import 'package:cinemapedia/infraestructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infraestructure/repository/moive_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider = Provider(
  (ref){
    return MoiveRepositoryImpl( datasource: MoviedbDatasource() );

  }
);