import 'Coordinate.dart';

class CarTwo {
  CarTwo({
    this.coordinate,
    this.icon,
    this.name,
  });

  CarTwo.fromJson(dynamic json) {
    coordinate = json['coordinate'] != null ? Coordinate.fromJson(json['coordinate']) : null;
    icon = json['icon'];
    name = json['name'];
  }

  Coordinate? coordinate;
  String? icon;
  String? name;

  CarTwo copyWith({
    Coordinate? coordinate,
    String? icon,
    String? name,
  }) =>
      CarTwo(
        coordinate: coordinate ?? this.coordinate,
        icon: icon ?? this.icon,
        name: name ?? this.name,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (coordinate != null) {
      map['coordinate'] = coordinate?.toJson();
    }
    map['icon'] = icon;
    map['name'] = name;
    return map;
  }
}
