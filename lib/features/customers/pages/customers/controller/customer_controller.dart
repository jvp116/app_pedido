import 'package:app_pedido/features/customers/models/customer_model.dart';
import 'package:app_pedido/features/customers/stores/customer_store.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class CustomerController extends ChangeNotifier {
  late CustomerStore? store;
  var state;

  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();

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

  Future<void> editCustomer(int id, String name, String lastname) async {
    if (store == null) {
      throw 'Não foi possível editar o cliente!';
    }

    CustomerModel customer = await store!.service.editCustomer(id, name, lastname);
    state.customers.insert(recoverIndex(id), customer);
    state.customers.removeAt(recoverIndex(id) + 1);

    notifyListeners();
  }

  Future<void> deleteCustomer(CustomerModel customer) async {
    bool isDeleted = await store!.service.deleteCustomer(customer.id);
    if (isDeleted) {
      state.customers.remove(customer);
    }
    notifyListeners();
  }

  String? validateCPF(String? value) {
    if (value == null || value.isEmpty) return 'Por favor, informe o CPF';

    if (!UtilBrasilFields.isCPFValido(value)) return 'CPF inválido';

    for (var customer in state.customers) {
      if (UtilBrasilFields.removeCaracteres(value) == customer.cpf) return 'CPF já existente';
    }

    return null;
  }

  initFormEdit(String name, String lastname) {
    nameController.text = name;
    lastnameController.text = lastname;
  }

  clearForm() {
    nameController.clear();
    lastnameController.clear();
  }

  int recoverIndex(int id) {
    for (var obj in state.customers) {
      if (obj.id == id) {
        return state.customers.indexOf(obj);
      }
    }
    return 0;
  }
}
