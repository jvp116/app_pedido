import 'package:app_pedido/features/products/models/new_product_model.dart';
import 'package:app_pedido/features/products/models/product_model.dart';
import 'package:app_pedido/shared/constants.dart';
import 'package:dio/dio.dart';

class ProductService {
  final Dio dio;

  ProductService(this.dio);

  Future<List<ProductModel>> fetchProducts() async {
    final response = await dio.get('$basePath/produtos');
    final list = response.data as List;
    return list.map((e) => NewProductModel.fromMap(e)).toList();
  }

  Future<ProductModel> createProduct(String description) async {
    Map<String, dynamic> data = {
      'descricao': description,
    };

    final response = await dio.post('$basePath/produtos', data: data);

    return NewProductModel.fromMap(response.data);
  }

  Future<ProductModel> editProduct(int id, String description) async {
    Map<String, dynamic> data = {
      'descricao': description,
    };

    final response = await dio.put('$basePath/produtos/$id', data: data);

    return NewProductModel.fromMap(response.data);
  }

  Future<bool> deleteProduct(int id) async {
    var response = await dio.delete('$basePath/produtos/$id');
    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }
}
