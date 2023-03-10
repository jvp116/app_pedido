import 'package:app_pedido/features/products/models/product_model.dart';
import 'package:app_pedido/features/products/stores/product_store.dart';
import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier {
  late ProductStore? store;
  var state;

  final formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();

  late bool isDescriptionEdited = false;

  late bool isCreated = false;
  late bool isEdited = false;
  late bool isDeleted = false;

  initialize(ProductStore newStore) {
    store = newStore;
    state = store!.value;
    notifyListeners();
  }

  Future<void> createProduct(String description) async {
    ProductModel product = await store!.createProduct(description);
    if (product.description.isNotEmpty) {
      isCreated = true;
      state.products.add(product);
    }
    notifyListeners();
  }

  Future<void> editProduct(int id, String description) async {
    ProductModel product = await store!.editProduct(id, description);
    if (product.description.isNotEmpty) {
      isEdited = true;
      state.products.insert(recoverIndex(id), product);
      state.products.removeAt(recoverIndex(id) + 1);
    }
    notifyListeners();
  }

  Future<void> deleteProduct(ProductModel product) async {
    isDeleted = await store!.deleteProduct(product.id);
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

  isSuccess() {
    String msg = '';
    Color color = const Color.fromARGB(255, 76, 175, 79);
    if (store == null) {
      throw 'Erro ao realizar ação!';
    }

    if (isCreated) {
      msg = "Produto cadastrado com sucesso!";
    } else if (isEdited) {
      msg = "Produto editado com sucesso!";
    } else if (isDeleted) {
      msg = "Produto excluído com sucesso!";
    } else {
      msg = "Ops! Algo deu errado.";
      color = const Color.fromARGB(255, 244, 67, 79);
    }
    resetActions();
    return SnackBar(
      content: Text(msg),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
    );
  }

  resetActions() {
    isCreated = false;
    isEdited = false;
    isDeleted = false;
  }
}
