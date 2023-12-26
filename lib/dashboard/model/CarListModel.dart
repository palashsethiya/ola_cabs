import 'CarOne.dart';
import 'CarTwo.dart';

class CarListModel {
  CarListModel({
    this.carOne,
    this.carTwo,
  });

  CarListModel.fromJson(dynamic json) {
    carOne = json['CarOne'] != null ? CarOne.fromJson(json['CarOne']) : null;
    carTwo = json['CarTwo'] != null ? CarTwo.fromJson(json['CarTwo']) : null;
  }

  CarOne? carOne;
  CarTwo? carTwo;

  CarListModel copyWith({
    CarOne? carOne,
    CarTwo? carTwo,
  }) =>
      CarListModel(
        carOne: carOne ?? this.carOne,
        carTwo: carTwo ?? this.carTwo,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (carOne != null) {
      map['CarOne'] = carOne?.toJson();
    }
    if (carTwo != null) {
      map['CarTwo'] = carTwo?.toJson();
    }
    return map;
  }
}
