import 'package:app_pedido/features/customers/models/customer_model.dart';

class NewCustomerModel {
  static CustomerModel fromMap(Map<String, dynamic> map) {
    return CustomerModel(id: map['id'] ?? 0, cpf: map['cpf'] ?? '', name: map['nome'] ?? '', lastname: map['sobrenome'] ?? '');
  }

  static Map<String, dynamic> toMap(CustomerModel customer) {
    return {
      'id': customer.id,
      'cpf': customer.cpf,
      'nome': customer.name,
      'sobrenome': customer.lastname
    };
  }
}
