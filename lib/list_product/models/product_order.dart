import 'package:test_twistcode/list_product/models/default_photo_model.dart';
import 'package:test_twistcode/list_product/models/product_model.dart';

class ProductOrder {
  final Product product;
  int quantity;

  ProductOrder({
    required this.product,
    required this.quantity,
  });
}
