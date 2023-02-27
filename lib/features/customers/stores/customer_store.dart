import 'package:app_pedido/features/customers/services/customer_service.dart';
import 'package:app_pedido/features/customers/states/customer_state.dart';
import 'package:flutter/material.dart';

class CustomerStore extends ValueNotifier<CustomerState> {
  final CustomerService service;

  CustomerStore(this.service) : super(InitialCustomerState());

  Future fetchCustomers() async {
    value = LoadingCustomerState();
    try {
      final customers = await service.fetchCustomers();
      value = SuccessCustomerState(customers);
    } catch (e) {
      value = ErrorCustomerState(e.toString());
    }
  }

  Future createCustomer(String cpf, String name, String lastname) async {
    value = LoadingCustomerState();
    try {
      await service.createCustomer(cpf, name, lastname);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future editCustomer(int id, String name, String lastname) async {
    value = LoadingCustomerState();
    try {
      await service.editCustomer(id, name, lastname);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future deleteCustomer(int id) async {
    value = LoadingCustomerState();
    try {
      await service.deleteCustomer(id);
      return true;
    } catch (e) {
      return false;
    }
  }
}
