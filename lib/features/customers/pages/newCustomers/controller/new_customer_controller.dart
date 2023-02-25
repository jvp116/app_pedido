import 'package:app_pedido/features/customers/pages/customers/controller/customer_controller.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class NewCustomerController extends ChangeNotifier {
  final CustomerController controller;
  NewCustomerController(this.controller);

  final formKey = GlobalKey<FormState>();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();

  Future<void> createCustomer() async {
    String cpf = UtilBrasilFields.removeCaracteres(cpfController.text);
    await controller.createCustomer(cpf, nameController.text, lastnameController.text);
  }
}
