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
}