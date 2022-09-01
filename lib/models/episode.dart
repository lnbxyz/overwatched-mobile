class Episode {
  String? id;
  String? season;
  String? name;
  int? duration;
  int? number;
  bool? watched;

  Episode({
    this.id,
    this.number,
    this.name,
    this.duration,
    this.season,
    this.watched
  });
}