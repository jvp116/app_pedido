import 'package:app_pedido/features/customers/models/customer_model.dart';
import 'package:app_pedido/features/customers/models/new_customer_model.dart';
import 'package:app_pedido/shared/constants.dart';
import 'package:dio/dio.dart';

class CustomerService {
  final Dio dio;

  CustomerService(this.dio);

  Future<List<CustomerModel>> fetchCustomers() async {
    final response = await dio.get('$basePath/clientes');
    final list = response.data as List;
    return list.map((e) => NewCustomerModel.fromMap(e)).toList();
  }

  Future<CustomerModel> createCustomer(String cpf, String name, String lastname) async {
    Map<String, dynamic> data = {
      'cpf': cpf,
      'nome': name,
      'sobrenome': lastname,
    };

    final response = await dio.post('$basePath/clientes', data: data);

    return NewCustomerModel.fromMap(response.data);
  }

  Future<CustomerModel> editCustomer(int id, String name, String lastname) async {
    Map<String, dynamic> data = {
      'nome': name,
      'sobrenome': lastname,
    };

    final response = await dio.put('$basePath/clientes/$id', data: data);

    return NewCustomerModel.fromMap(response.data);
  }

  Future<bool> deleteCustomer(int id) async {
    var response = await dio.delete('$basePath/clientes/$id');
    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }
}
