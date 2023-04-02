import 'package:app_pedido/features/products/models/new_product_model.dart';
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

  static ItemModel fromMap(Map<String, dynamic> map) {
    return ItemModel(id: map['id'] ?? 0, quantity: map['quantidade'] ?? 0, product: NewProductModel.fromMap(map['produto'] ?? ''));
  }

  static Map<String, dynamic> toMap(ItemModel item) {
    return {
      'id': item.id,
      'quantidade': item.quantity,
      'produto': item.product,
    };
  }
}
