import 'package:app_pedido/features/customers/models/customer_model.dart';
import 'package:app_pedido/features/order/models/item_model.dart';
import 'package:app_pedido/features/order/models/order_model.dart';
import 'package:app_pedido/features/order/stores/order_store.dart';
import 'package:flutter/material.dart';

class OrderController extends ChangeNotifier {
  late OrderStore? store;
  var state;

  final formKey = GlobalKey<FormState>();
  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController lastnameController = TextEditingController();

  // late bool isNameEdited = false;
  // late bool isLastnameEdited = false;

  late bool isCreated = false;
  late bool isDeleted = false;

  initialize(OrderStore newStore) {
    store = newStore;
    state = store!.value;
    notifyListeners();
  }

  Future<void> createOrder(String date, CustomerModel customer, List<ItemModel> items) async {
    OrderModel order = await store!.createOrder(date, customer, items);
    if (order.items.isNotEmpty) {
      isCreated = true;
      state.orders.add(order);
    }
    notifyListeners();
  }

  Future<void> deleteOrder(OrderModel order) async {
    isDeleted = await store!.deleteOrder(order.id);
    if (isDeleted) {
      state.orders.remove(order);
    }
    notifyListeners();
  }

  // clearForm() {
  //   nameController.clear();
  //   lastnameController.clear();
  // }

  int recoverIndex(int id) {
    for (var obj in state.orders) {
      if (obj.id == id) {
        return state.orders.indexOf(obj);
      }
    }
    return 0;
  }

  isSuccess() {
    String msg = '';
    Color color = const Color.fromARGB(167, 76, 175, 80);
    if (store == null) {
      throw 'Erro ao realizar ação!';
    }

    if (isCreated) {
      msg = "Pedido cadastrado com sucesso!";
    } else if (isDeleted) {
      msg = "Pedido excluído com sucesso!";
    } else {
      msg = "Ops! Algo deu errado.";
      color = const Color.fromARGB(163, 244, 67, 80);
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
    isDeleted = false;
  }
}
