class Episode {
  String id;
  String season;
  String name;
  int duration;
  int number;
  bool watched;

  Episode({
    this.id = '',
    this.number = 0,
    this.name = '',
    this.duration = 0,
    this.season = '',
    this.watched = false
  });

  Episode.fromJson(Map<String, dynamic> json)
      : id = json['_id'] ?? '',
        season = json['season'] ?? '',
        name = json['name'] ?? '',
        duration = json['duration'] ?? 0,
        number = json['number'] ?? 0,
        watched = json['watched'] ?? false;

  static Map<String, dynamic> toJson(Episode value) => {
    '_id': value.id == '' ? null : value.id,
    'season': value.season,
    'name': value.name,
    'duration': value.duration,
    'number': value.number,
    'watched': value.watched,
  };
}