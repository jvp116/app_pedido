import 'package:app_pedido/features/orders/models/order_model.dart';
import 'package:flutter/material.dart';

class SearchOrderController {
  final TextEditingController searchController = TextEditingController();

  filterByCpf(List<OrderModel> orders, String cpf) {
    var ordersByCpf = List<OrderModel>.of(orders);
    ordersByCpf.retainWhere((order) => order.customer.cpf.startsWith(cpf));

    if (cpf.isEmpty || ordersByCpf.isEmpty) {
      return orders;
    }
    cpf = "";
    return ordersByCpf;
  }
}
