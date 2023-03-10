import 'package:app_pedido/features/customers/models/customer_model.dart';
import 'package:app_pedido/features/orders/models/item_model.dart';
import 'package:app_pedido/features/orders/services/order_service.dart';
import 'package:app_pedido/features/orders/states/order_state.dart';
import 'package:flutter/material.dart';

class OrderStore extends ValueNotifier<OrderState> {
  final OrderService service;

  OrderStore(this.service) : super(InitialOrderState());

  Future fetchOrders() async {
    value = LoadingOrderState();
    try {
      final orders = await service.fetchOrders();
      value = SuccessOrderState(orders);
    } catch (e) {
      value = ErrorOrderState(e.toString());
    }
  }

  Future createOrder(String date, CustomerModel customer, List<ItemModel> items) async {
    try {
      return await service.createOrder(date, customer, items);
    } catch (e) {
      rethrow;
    }
  }

  Future deleteOrder(int id) async {
    try {
      return await service.deleteOrder(id);
    } catch (e) {
      rethrow;
    }
  }
}
