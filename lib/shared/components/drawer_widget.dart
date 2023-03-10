import 'package:app_pedido/shared/utils/navigate.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
            ),
            child: Text('App'),
          ),
          ListTile(
            title: const Text('Clientes'),
            onTap: () {
              Navigate().toCustomerPage(context);
            },
          ),
          ListTile(
            title: const Text('Produtos'),
            onTap: () {
              Navigate().toProductPage(context);
            },
          ),
          ListTile(
            title: const Text('Pedidos'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
