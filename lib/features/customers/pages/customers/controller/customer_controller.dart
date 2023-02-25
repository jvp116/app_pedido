import 'package:app_pedido/features/customers/models/customer_model.dart';
import 'package:app_pedido/features/customers/stores/customer_store.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class CustomerController extends ChangeNotifier {
  late CustomerStore? store;
  var state;

  initialize(CustomerStore newStore) {
    store = newStore;
    state = store!.value;
    notifyListeners();
  }

  Future<void> createCustomer(String cpf, String name, String lastname) async {
    if (store == null) {
      throw 'Não foi possível cadastrar o cliente!';
    }
    CustomerModel customer = await store!.service.createCustomer(cpf, name, lastname);
    state.customers.add(customer);
    notifyListeners();
  }

  deleteCustomer(CustomerModel customer) async {
    bool isDeleted = await store!.service.deleteCustomer(customer.id);
    if (isDeleted) {
      state.customers.remove(customer);
    }
    notifyListeners();
  }

  String? validateCPF(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, informe o CPF';
    }
    if (!UtilBrasilFields.isCPFValido(value)) {
      return 'CPF inválido';
    }
    return null;
  }
}
