import 'package:mobx/mobx.dart';

//flutter pub run build_runner build
part 'serie.g.dart';

class Serie = _Serie with _$Serie;

abstract class _Serie with Store {
  String id;
  String name;
  String coverUrl;
  String description;
  String releaseYear;
  String endingYear;
  List<String> genres;
  double score;

  _Serie({
    this.id = '',
    this.name = '',
    this.coverUrl = '',
    this.description = '',
    this.releaseYear = '',
    this.endingYear = '',
    this.genres = const [],
    this.score = 0
  });
}