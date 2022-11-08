class Serie {
  String id;
  String name;
  String? coverUrl;
  String? description;
  String releaseYear;
  String? endingYear;
  List<String> genres;
  double? score;

  Serie(
      {this.id = '',
      this.name = '',
      this.coverUrl = '',
      this.description = '',
      this.releaseYear = '',
      this.endingYear = '',
      this.genres = const [],
      this.score = 0});

  Serie.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        coverUrl = json['coverUrl'],
        description = json['description'],
        releaseYear = json['releaseYear'],
        endingYear = json['endingYear'],
        genres = List.castFrom(json['genres']),
        score = json['score'];

  static Map<String, dynamic> toJson(Serie value) => {
        '_id': value.id,
        'name': value.name,
        'coverUrl': value.coverUrl,
        'description': value.description,
        'releaseYear': value.releaseYear,
        'endingYear': value.endingYear,
        'genres': value.genres,
        'score': value.score,
      };
}
