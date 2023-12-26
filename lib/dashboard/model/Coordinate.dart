class Coordinate {
  Coordinate({
    this.latitude,
    this.longitude,
  });

  Coordinate.fromJson(dynamic json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  double? latitude;
  double? longitude;

  Coordinate copyWith({
    double? latitude,
    double? longitude,
  }) =>
      Coordinate(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }
}
