// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_pedido/features/orders/pages/orders/controller/order_controller.dart';
import 'package:app_pedido/features/orders/pages/searchListOrders/presenter/search_list_order_page.dart';
import 'package:app_pedido/features/orders/pages/searchOrders/controller/search_order_controller.dart';
import 'package:flutter/material.dart';

class SearchOrderPage extends StatefulWidget {
  final OrderController orderController;

  const SearchOrderPage({super.key, required this.orderController});

  @override
  State<SearchOrderPage> createState() => _SearchOrderPageState();
}

class _SearchOrderPageState extends State<SearchOrderPage> {
  final SearchOrderController controller = SearchOrderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextFormField(
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    iconSize: 16,
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      /* Clear the search field */
                    },
                  ),
                  hintText: 'Pesquisar...',
                  border: InputBorder.none),
              autofocus: true,
              enableSuggestions: true,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  spacing: 16.0,
                  children: OrderFilter.values.map((OrderFilter orderFilter) {
                    return FilterChip(
                      selectedColor: Colors.deepPurple,
                      label: Text(orderFilter.name),
                      selected: controller.filters.contains(orderFilter.name),
                      onSelected: (bool value) {
                        setState(() {
                          if (value) {
                            if (!controller.filters.contains(orderFilter.name) && controller.filters.isEmpty) {
                              controller.filters.add(orderFilter.name);
                            }
                          } else {
                            controller.filters.removeWhere((String name) {
                              return name == orderFilter.name;
                            });
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          SearchListOrderPage(controller: widget.orderController)
        ],
      ),
    );
  }
}
