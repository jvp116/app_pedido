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
    value = LoadingProductState();
    try {
      await service.createProduct(description);
      value = SuccessCreateProductState();
    } catch (e) {
      value = ErrorProductState(e.toString());
    }
  }

  Future editProduct(int id, String description) async {
    value = LoadingProductState();
    try {
      await service.editProduct(id, description);
      value = SuccessEditProductState();
    } catch (e) {
      value = ErrorProductState(e.toString());
    }
  }

  Future deleteProduct(int id) async {
    value = LoadingProductState();
    try {
      await service.deleteProduct(id);
      value = SuccessDeleteProductState();
    } catch (e) {
      value = ErrorProductState(e.toString());
    }
  }
}
