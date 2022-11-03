import 'package:mobx/mobx.dart';

//flutter pub run build_runner build
part 'season.g.dart';

class Season = _Season with _$Season;

abstract class _Season with Store {
  String id;
  String series;
  String name;
  int number;

  _Season({
    this.id = '',
    this.name = '',
    this.number = 0,
    this.series = ''
  });
}