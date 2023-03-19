import 'package:app_pedido/features/customers/pages/customers/controller/customer_controller.dart';
import 'package:app_pedido/features/customers/pages/customers/presenter/customer_page.dart';
import 'package:app_pedido/features/customers/pages/newCustomers/presenter/new_customer_page.dart';
import 'package:app_pedido/features/orders/pages/orders/controller/order_controller.dart';
import 'package:app_pedido/features/orders/pages/searchOrders/presentation/search_order_page.dart';
import 'package:app_pedido/features/products/pages/newProducts/presenter/new_product_page.dart';
import 'package:app_pedido/features/products/pages/products/controller/product_controller.dart';
import 'package:app_pedido/features/products/pages/products/presenter/product_page.dart';
import 'package:flutter/material.dart';

class Navigate {
  void toCustomerPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CustomerPage(),
      ),
    );
  }

  void toProductPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProductPage(),
      ),
    );
  }

  void toNewCustomerPage(BuildContext context, CustomerController controller) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewCustomerPage(controller: controller),
      ),
    );
  }

  void toNewProductPage(BuildContext context, ProductController controller) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewProductPage(controller: controller),
      ),
    );
  }

  void toNewOrderPage(BuildContext context, OrderController controller) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => NewOrderPage(controller: controller),
    //   ),
    // );
  }

  void toSearchOrderPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchOrderPage(),
      ),
    );
  }
}
