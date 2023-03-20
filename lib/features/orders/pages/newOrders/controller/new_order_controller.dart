import 'package:app_pedido/features/orders/pages/orders/controller/order_controller.dart';
import 'package:flutter/material.dart';

class NewOrderController extends ChangeNotifier {
  final OrderController controller;
  NewOrderController(this.controller);

  final formKey = GlobalKey<FormState>();
  final TextEditingController cpfController = TextEditingController();

  Future<void> createOrder() async {
    // String cpf = UtilBrasilFields.removeCaracteres(cpfController.text);
    // await controller.createCustomer(cpf, nameController.text, lastnameController.text);
  }
}
