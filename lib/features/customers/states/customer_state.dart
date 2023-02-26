import 'package:app_pedido/features/customers/models/customer_model.dart';

abstract class CustomerState {}

// Initial, Success, Error, Loading
class InitialCustomerState extends CustomerState {}

class SuccessCustomerState extends CustomerState {
  final List<CustomerModel> customers;
  SuccessCustomerState(this.customers);
}

class LoadingCustomerState extends CustomerState {}

class ErrorCustomerState extends CustomerState {
  final String message;

  ErrorCustomerState(this.message);
}

// create
class SuccessCreateCustomerState extends CustomerState {}

// edit
class SuccessEditCustomerState extends CustomerState {}

// delete
class SuccessDeleteCustomerState extends CustomerState {}
