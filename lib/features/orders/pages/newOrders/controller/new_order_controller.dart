import 'package:app_pedido/features/customers/models/customer_model.dart';
import 'package:app_pedido/features/orders/models/item_model.dart';
import 'package:app_pedido/features/orders/models/order_model.dart';
import 'package:app_pedido/features/orders/pages/orders/controller/order_controller.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class NewOrderController extends ChangeNotifier {
  final OrderController controller;
  NewOrderController(this.controller);

  OrderModel newOrder = OrderModel(id: 0, date: "", customer: CustomerModel(id: 0, cpf: "", name: "", lastname: ""), items: []);

  // form
  final formKey = GlobalKey<FormState>();
  final TextEditingController cpfController = TextEditingController();

  bool isFindCustomer = false;

  Future<void> createOrder() async {
    await controller.createOrder("", newOrder.customer, newOrder.items);
  }

  findCustomer(List<CustomerModel> customers) {
    for (var customer in customers) {
      if (UtilBrasilFields.removeCaracteres(cpfController.text) == customer.cpf) {
        isFindCustomer = true;
        newOrder.customer = customer;
      }
    }
  }

  isFind() {
    if (isFindCustomer) {
      isFindCustomer = false;

      return const SnackBar(
        content: Text("Cliente adicionado com sucesso!"),
        backgroundColor: Color.fromARGB(167, 76, 175, 80),
      );
    }
    return const SnackBar(content: Text("Não existe um cliente com esse CPF!"), backgroundColor: Color.fromARGB(161, 235, 223, 0));
  }

  isSelectedProduct(ItemModel itemSelected) {
    bool isSelected = false;

    for (var item in newOrder.items) {
      if (item.product == itemSelected.product) {
        isSelected = true;
      }
    }

    if (!isSelected) {
      newOrder.items.add(itemSelected);
      isSelected = false;
    }
  }
}
