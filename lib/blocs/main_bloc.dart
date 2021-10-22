import 'dart:async';

import 'package:rxdart/subjects.dart';

class MainBloc {
  final BehaviorSubject<MainPageState> stateSubject = BehaviorSubject();

  Stream<MainPageState> observeMainPageState() => stateSubject;

  MainBloc() {
    stateSubject.add(MainPageState.noFavorites);
  }

  void nextState() {
    final currentState = stateSubject.value;
    final nextState = MainPageState.values[
        (MainPageState.values.indexOf(currentState) + 1) %
            MainPageState.values.length];
    stateSubject.sink.add(nextState);
  }

  void updateText(final String? text){
    print("GOT NEW TEXT : $text");
  }

  void dispose() {
    stateSubject.close();
  }
}
//
enum MainPageState {
  noFavorites,
  minSymbols,
  loading,
  nothingFound,
  loadingError,
  searchResults,
  favorites,
}

class SuperheroInfo {

  final String name;
  final String realName;
  final String imageUrl;

  const SuperheroInfo(this.name, this.realName, this.imageUrl);



}
