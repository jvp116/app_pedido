import 'package:app_pedido/features/customers/models/customer_model.dart';
import 'package:app_pedido/features/customers/models/new_customer_model.dart';
import 'package:app_pedido/features/orders/models/item_model.dart';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date,
      'customer': NewCustomerModel.toMap(customer),
      'items': items.map((item) => ItemModel.toMap(item)).toList(),
    };
  }

  static OrderModel fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? 0,
      date: map['data'] ?? '',
      customer: NewCustomerModel.fromMap(map['cliente'] ?? []),
      items: List<ItemModel>.from(
        (map['itens'] ?? []).map<ItemModel>(
          (item) => ItemModel.fromMap(item as Map<String, dynamic>),
        ),
      ),
    );
  }
}
