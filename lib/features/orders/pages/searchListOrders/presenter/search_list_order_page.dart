import 'package:app_pedido/features/orders/models/order_model.dart';
import 'package:app_pedido/features/orders/pages/listOrders/controller/list_order_controller.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class SearchListOrderPage extends StatefulWidget {
  final List<OrderModel> orders;

  const SearchListOrderPage({super.key, required this.orders});

  @override
  State<SearchListOrderPage> createState() => _SearchListOrderPageState();
}

class _SearchListOrderPageState extends State<SearchListOrderPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.orders.length,
        itemBuilder: (context, index) {
          final order = widget.orders[index];
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
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("CPF: ${UtilBrasilFields.obterCpf(order.customer.cpf)}"),
                              IconButton(
                                icon: const Icon(Icons.close_rounded),
                                color: Colors.deepPurpleAccent,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                          Text("Pedido ${order.id}", style: const TextStyle(fontSize: 24)),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Total de items: ${order.items.length}", style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Table(
                            border: TableBorder.all(borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)), color: Colors.deepPurple),
                            columnWidths: const <int, TableColumnWidth>{
                              0: FixedColumnWidth(128),
                              1: FlexColumnWidth(),
                            },
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                            children: <TableRow>[
                              TableRow(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    height: 32,
                                    child: const Text("Quantidade",
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                  ),
                                  TableCell(
                                    verticalAlignment: TableCellVerticalAlignment.middle,
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 32,
                                      width: 32,
                                      child: const Text("Descrição", style: TextStyle(fontSize: 16)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Table(
                                border: TableBorder.all(borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)), color: Colors.deepPurple),
                                columnWidths: const <int, TableColumnWidth>{
                                  0: FixedColumnWidth(128),
                                  1: FlexColumnWidth(),
                                },
                                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                children: ListOrderController().renderTableItems(order.items),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
