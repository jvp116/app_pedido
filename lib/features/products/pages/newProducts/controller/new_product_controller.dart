import 'package:app_pedido/features/products/pages/products/controller/product_controller.dart';
import 'package:flutter/material.dart';

class NewProductController extends ChangeNotifier {
  final ProductController controller;
  NewProductController(this.controller);

  final formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> createProduct() async {
    await controller.createProduct(descriptionController.text);
  }
}
