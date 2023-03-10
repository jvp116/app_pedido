import 'package:app_pedido/features/order/pages/orders/controller/order_controller.dart';
import 'package:brasil_fields/brasil_fields.dart';
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

          return ListTile(
            leading: Text('${order.id}', style: const TextStyle(fontSize: 14)),
            title: Text(order.customer.name),
            subtitle: Text(order.date),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 160,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${order.customer.name} ${order.customer.lastname}", style: const TextStyle(fontSize: 24)),
                          const SizedBox(height: 16),
                          Text(UtilBrasilFields.obterCpf(order.cpf), style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            child: const Text('Fechar'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            trailing: PopupMenuButton(
              color: Colors.deepPurpleAccent,
              icon: const Icon(Icons.more_vert_rounded),
              itemBuilder: (context) => [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Excluir",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(Icons.delete_rounded)
                    ],
                  ),
                ),
              ],
              onSelected: (item) => {
                if (item == 0)
                  {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Excluir Cliente'),
                        content: const Text('Tem certeza que deseja excluir esse produto?'),
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
                    )
                  }
              },
            ),
          );
        },
      ),
    );
  }
}
