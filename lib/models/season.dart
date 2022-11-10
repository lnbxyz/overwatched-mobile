class Season {
  String id;
  String series;
  String name;
  int? number;

  Season({
    this.id = '',
    this.name = '',
    this.number = 0,
    this.series = ''
  });

  Season.fromJson(Map<String, dynamic> json)
      : id = json['_id'] ?? '',
        name = json['name'] ?? '',
        series = json['series'] ?? '',
        number = json['number'];

  static Map<String, dynamic> toJson(Season value) => {
    '_id': value.id == '' ? null : value.id,
    'name': value.name,
    'series': value.series,
    'number': value.number,
  };
}