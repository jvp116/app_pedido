import 'package:app_pedido/features/products/models/product_model.dart';
import 'package:app_pedido/shared/constants.dart';
import 'package:dio/dio.dart';

class ProductService {
  final Dio dio;

  ProductService(this.dio);

  Future<List<ProductModel>> fetchProducts() async {
    final response = await dio.get('$basePath/produtos');
    final list = response.data as List;
    return list.map((e) => ProductModel.fromMap(e)).toList();
  }

  Future<void> deleteProduct(int id) async {
    await dio.delete('$basePath/produtos/$id');
  }
}
