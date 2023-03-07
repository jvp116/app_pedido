import 'package:app_pedido/features/products/models/product_model.dart';
import 'package:app_pedido/features/products/services/product_service.dart';
import 'package:app_pedido/features/products/states/product_state.dart';
import 'package:flutter/material.dart';

class ProductStore extends ValueNotifier<ProductState> {
  final ProductService service;

  ProductStore(this.service) : super(InitialProductState());

  Future fetchProducts() async {
    value = LoadingProductState();
    try {
      final products = await service.fetchProducts();
      value = SuccessProductState(products);
    } catch (e) {
      value = ErrorProductState(e.toString());
    }
  }

  Future createProduct(String description) async {
    try {
      return await service.createProduct(description);
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductModel> editProduct(int id, String description) async {
    try {
      ProductModel customer = await service.editProduct(id, description);
      return customer;
    } catch (e) {
      rethrow;
    }
  }

  Future deleteProduct(int id) async {
    try {
      return await service.deleteProduct(id);
    } catch (e) {
      rethrow;
    }
  }
}
