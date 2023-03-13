import 'package:app_pedido/features/orders/pages/orders/controller/order_controller.dart';
import 'package:flutter/material.dart';

class ListOrder extends StatefulWidget {
  final OrderController controller;

  const ListOrder({super.key, required this.controller});

  @override
  State<ListOrder> createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.controller.state.orders.length,
        itemBuilder: (context, index) {
          final order = widget.controller.state.orders[index];
          final item = order.items[index];
          final formatDate = order.date.split(' ');

          return ListTile(
            leading: Text('${order.id}', style: const TextStyle(fontSize: 14)),
            title: Text("${order.customer.name} ${order.customer.lastname}"),
            subtitle: Text(formatDate[0]),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 450,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Pedido ${order.id}", style: const TextStyle(fontSize: 24)),
                              IconButton(
                                icon: const Icon(Icons.close_rounded),
                                color: Colors.deepPurple,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Icon(Icons.person_outline_rounded, color: Colors.deepPurple),
                              Text(" ${order.customer.name} ${order.customer.lastname}", style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.date_range_rounded, color: Colors.deepPurple),
                              Text(" ${formatDate[0]}", style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.access_time_rounded, color: Colors.deepPurple),
                              Text(" ${formatDate[1]}", style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            title: Text("${item.quantity} ${item.product.description}", style: const TextStyle(fontSize: 16)),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Excluir Cliente'),
                    content: const Text('Tem certeza que deseja excluir esse pedido?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Não'),
                        child: const Text('Não'),
                      ),
                      TextButton(
                        onPressed: () {
                          widget.controller.deleteOrder(order).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(widget.controller.isSuccess());
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('Sim'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete_rounded),
              color: Colors.deepPurpleAccent,
            ),
          );
        },
      ),
    );
  }
}
