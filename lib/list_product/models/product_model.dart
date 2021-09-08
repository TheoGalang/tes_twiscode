import 'package:test_twistcode/list_product/models/default_photo_model.dart';

class Product {
  final String title;
  final String id;
  final String price;
  final String locationName;
  final DefaultPhoto defaultPhoto;
  final String isHalal;
  final String addedUsername;

  Product({
    required this.title,
    required this.id,
    required this.price,
    required this.locationName,
    required this.defaultPhoto,
    required this.isHalal,
    required this.addedUsername,
  });

  factory Product.fromjson(Map<String, dynamic> json) {
    return Product(
        title: json['title'],
        id: json['id'],
        price: json['price'],
        locationName: json['location_name'],
        defaultPhoto: DefaultPhoto.fromJson(json['default_photo']),
        isHalal: json['is_halal'],
        addedUsername: json['added_user_name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'id': this.id,
      'price': this.price,
      'location_name': this.locationName,
      'default_photo': this.defaultPhoto.toJson(),
      'is_halal': this.isHalal,
      'added_user_name': this.addedUsername,
    };
  }
}
