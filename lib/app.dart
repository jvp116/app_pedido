import 'package:app_pedido/features/customers/services/customer_service.dart';
import 'package:app_pedido/features/customers/stores/customer_store.dart';
import 'package:app_pedido/features/order/pages/orders/presenter/order_page.dart';
import 'package:app_pedido/features/order/services/order_service.dart';
import 'package:app_pedido/features/order/stores/order_store.dart';
import 'package:app_pedido/features/products/services/product_service.dart';
import 'package:app_pedido/features/products/stores/product_store.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => Dio()),
        Provider(create: (context) => CustomerService(context.read())),
        Provider(create: (context) => ProductService(context.read())),
        Provider(create: (context) => OrderService(context.read())),
        ChangeNotifierProvider(create: (context) => CustomerStore(context.read())),
        ChangeNotifierProvider(create: (context) => ProductStore(context.read())),
        ChangeNotifierProvider(create: (context) => OrderStore(context.read()))
      ],
      child: MaterialApp(
        title: 'App',
        theme: ThemeData(
          colorScheme: const ColorScheme.dark(),
          useMaterial3: true,
        ),
        home: const OrderPage(),
      ),
    );
  }
}
