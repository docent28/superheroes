import 'package:superheroes/model/superhero.dart';

class FavoriteSuperheroesStorage {

  Future<bool> addToFavorites(final Superhero superhero) {
    throw UnimplementedError();
  }

  Future<bool> removeFromFavorites(final String id) {
    throw UnimplementedError();
  }

  Future<Superhero?> getSuperhero(final String id) {
    throw UnimplementedError();
  }

  Stream<List<Superhero>> observeFavoriteSuperheroes(){
    throw UnimplementedError();
  }

  Stream<List<Superhero>> observeIsFavorite(final String id){
    throw UnimplementedError();
  }

}
