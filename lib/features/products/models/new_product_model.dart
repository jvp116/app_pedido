import 'package:app_pedido/features/products/models/product_model.dart';

class NewProductModel {
  static ProductModel fromMap(Map<String, dynamic> map) {
    return ProductModel(id: map['id'] ?? 0, description: map['descricao'] ?? '');
  }

  static Map<String, dynamic> toMap(ProductModel product) {
    return {
      'id': product.id,
      'descricao': product.description,
    };
  }
}
