import 'package:mobx/mobx.dart';

//flutter pub run build_runner build
part 'episode.g.dart';

class Episode = _Episode with _$Episode;

abstract class _Episode with Store {
  String id;
  String season;
  String name;
  int duration;
  int number;
  bool watched;

  _Episode({
    this.id = '',
    this.number = 0,
    this.name = '',
    this.duration = 0,
    this.season = '',
    this.watched = false
  });
}