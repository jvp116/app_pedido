import 'package:app_pedido/features/customers/models/customer_model.dart';
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
    try {
      return await service.createCustomer(cpf, name, lastname);
    } catch (e) {
      rethrow;
    }
  }

  Future<CustomerModel> editCustomer(int id, String name, String lastname) async {
    try {
      CustomerModel customer = await service.editCustomer(id, name, lastname);
      return customer;
    } catch (e) {
      rethrow;
    }
  }

  Future deleteCustomer(int id) async {
    try {
      return await service.deleteCustomer(id);
    } catch (e) {
      rethrow;
    }
  }
}
