import 'package:app_pedido/features/products/models/product_model.dart';
import 'package:app_pedido/features/products/stores/product_store.dart';
import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier {
  late ProductStore? store;
  var state;

  final formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();

  late bool isDescriptionEdited = false;

  initialize(ProductStore newStore) {
    store = newStore;
    state = store!.value;
    notifyListeners();
  }

  Future<void> createProduct(String description) async {
    if (store == null) {
      throw 'Não foi possível cadastrar o produto!';
    }
    ProductModel product = await store!.service.createProduct(description);
    state.products.add(product);
    notifyListeners();
  }

  Future<void> editProduct(int id, String description) async {
    if (store == null) {
      throw 'Não foi possível editar o produto!';
    }

    ProductModel product = await store!.service.editProduct(id, description);
    state.products.insert(recoverIndex(id), product);
    state.products.removeAt(recoverIndex(id) + 1);

    notifyListeners();
  }

  Future<void> deleteProduct(ProductModel product) async {
    bool isDeleted = await store!.service.deleteProduct(product.id);
    if (isDeleted) {
      state.products.remove(product);
    }
    notifyListeners();
  }

  initFormEdit(String description) {
    descriptionController.text = description;
  }

  clearForm() {
    descriptionController.clear();
  }

  int recoverIndex(int id) {
    for (var obj in state.products) {
      if (obj.id == id) {
        return state.products.indexOf(obj);
      }
    }
    return 0;
  }
}
