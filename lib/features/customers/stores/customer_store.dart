import 'package:app_pedido/features/customers/models/new_customer_model.dart';
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
      value = SuccessCreateCustomerState();
    } catch (e) {
      value = ErrorCustomerState(e.toString());
    }
  }

  Future deleteCustomer(int id) async {
    value = LoadingCustomerState();
    try {
      await service.deleteCustomer(id);
      value = SuccessDeleteCustomerState();
    } catch (e) {
      value = ErrorCustomerState(e.toString());
    }
  }
}
