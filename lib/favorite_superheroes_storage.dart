import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:superheroes/model/superhero.dart';

class FavoriteSuperheroesStorage {
  static const _key = "favorite_superheroes";

  Future<bool> addToFavorites(final Superhero superhero) async {
    final sp = await SharedPreferences.getInstance();
    final rawSuperheroes = sp.getStringList(_key) ?? [];
    rawSuperheroes.add(json.encode(superhero.toJson()));
    return sp.setStringList(_key, rawSuperheroes);
  }

  Future<bool> removeFromFavorites(final String id) async {
    final sp = await SharedPreferences.getInstance();
    final rawSuperheroes = sp.getStringList(_key) ?? [];
    final superheroes = rawSuperheroes
        .map((rawSuperhero) => Superhero.fromJson(json.decode(rawSuperhero)))
        .toList();
    superheroes.removeWhere((superhero) => superhero.id == id);
    final updatedRawSuperheroes = superheroes
        .map((superhero) => json.encode(superhero.toJson()))
        .toList();
    return sp.setStringList(_key, updatedRawSuperheroes);
  }

  Future<Superhero?> getSuperhero(final String id) {
    throw UnimplementedError();
  }

  Stream<List<Superhero>> observeFavoriteSuperheroes() {
    throw UnimplementedError();
  }

  Stream<List<Superhero>> observeIsFavorite(final String id) {
    throw UnimplementedError();
  }
}
