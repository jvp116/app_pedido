import 'package:app_pedido/features/customers/models/customer_model.dart';
import 'package:app_pedido/features/order/models/item_model.dart';

class OrderModel {
  int id;
  String date;
  CustomerModel customer;
  List<ItemModel> items;
  OrderModel({
    required this.id,
    required this.date,
    required this.customer,
    required this.items,
  });

  static OrderModel fromMap(Map<String, dynamic> map) {
    return OrderModel(id: map['id'] ?? 0, date: map['data'] ?? '', customer: map['cliente'] ?? '', items: map['itens'] ?? '');
  }

  static Map<String, dynamic> toMap(OrderModel order) {
    return {
      'id': order.id,
      'data': order.date,
      'cliente': order.customer,
      'itens': order.items
    };
  }
}
