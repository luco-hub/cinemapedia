

import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';

class ActorMoviedbDatasource extends ActorsDatasource {
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
   
   return[];
  }
}