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

  late bool isNameEdited = false;
  late bool isLastnameEdited = false;

  late bool isCreated = false;
  late bool isEdited = false;
  late bool isDeleted = false;
  late SnackBar snackBarWidget = isSuccess();

  initialize(CustomerStore newStore) {
    store = newStore;
    state = store!.value;
    notifyListeners();
  }

  Future<void> createCustomer(String cpf, String name, String lastname) async {
    CustomerModel customer = await store!.createCustomer(cpf, name, lastname);
    if (customer.cpf.isNotEmpty) {
      isCreated = true;
      state.customers.add(customer);
    }
    notifyListeners();
  }

  Future<void> editCustomer(int id, String name, String lastname) async {
    CustomerModel customer = await store!.editCustomer(id, name, lastname);
    if (customer.name.isNotEmpty && customer.lastname.isNotEmpty) {
      isEdited = true;
      state.customers.insert(recoverIndex(id), customer);
      state.customers.removeAt(recoverIndex(id) + 1);
    }
    notifyListeners();
  }

  Future<void> deleteCustomer(CustomerModel customer) async {
    isDeleted = await store!.deleteCustomer(customer.id);
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

  isSuccess() {
    String msg = '';
    Color color = const Color.fromARGB(167, 76, 175, 80);
    if (store == null) {
      throw 'Erro ao realizar ação!';
    }

    if (isCreated) {
      msg = "Cliente cadastrado com sucesso!";
    } else if (isEdited) {
      msg = "Cliente editado com sucesso!";
    } else if (isDeleted) {
      msg = "Cliente excluído com sucesso!";
    } else {
      msg = "Ops! Algo deu errado.";
      color = const Color.fromARGB(163, 244, 67, 80);
    }

    return SnackBar(
      content: Text(msg),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
    );
  }
}
