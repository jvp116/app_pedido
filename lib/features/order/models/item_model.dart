import 'package:app_pedido/features/products/models/product_model.dart';

class ItemModel {
  int id;
  int quantity;
  ProductModel product;
  ItemModel({
    required this.id,
    required this.quantity,
    required this.product,
  });
}
