import 'package:app_pedido/features/orders/models/order_model.dart';

abstract class OrderState {}

// Initial, Success, Error, Loading
class InitialOrderState extends OrderState {}

class SuccessOrderState extends OrderState {
  final List<OrderModel> orders;
  SuccessOrderState(this.orders);
}

class LoadingOrderState extends OrderState {}

class ErrorOrderState extends OrderState {
  final String message;

  ErrorOrderState(this.message);
}
