import 'package:app_pedido/features/customers/models/customer_model.dart';
import 'package:app_pedido/features/orders/models/item_model.dart';
import 'package:app_pedido/features/orders/models/order_model.dart';
import 'package:app_pedido/shared/constants.dart';
import 'package:dio/dio.dart';

class OrderService {
  final Dio dio;

  OrderService(this.dio);

  Future<List<OrderModel>> fetchOrders() async {
    final response = await dio.get('$basePath/pedidos');
    final list = response.data as List;
    return list.map((e) => OrderModel.fromMap(e)).toList();
  }

  Future<OrderModel> createOrder(String date, CustomerModel customer, List<ItemModel> items) async {
    Map<String, dynamic> data = {
      'data': date,
      'cliente': customer,
      'itens': items
    };

    final response = await dio.post('$basePath/pedidos', data: data);

    return OrderModel.fromMap(response.data);
  }

  Future<bool> deleteOrder(int id) async {
    var response = await dio.delete('$basePath/pedidos/$id');
    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }
}
