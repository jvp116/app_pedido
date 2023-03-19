// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_pedido/features/orders/pages/orders/controller/order_controller.dart';
import 'package:app_pedido/features/orders/pages/searchListOrders/presenter/search_list_order_page.dart';
import 'package:app_pedido/features/orders/pages/searchOrders/controller/search_order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchOrderPage extends StatefulWidget {
  final OrderController orderController;

  const SearchOrderPage({super.key, required this.orderController});

  @override
  State<SearchOrderPage> createState() => _SearchOrderPageState();
}

class _SearchOrderPageState extends State<SearchOrderPage> {
  final SearchOrderController controller = SearchOrderController();
  var list = const SearchListOrderPage(orders: []);

  @override
  void initState() {
    super.initState();
    list = SearchListOrderPage(orders: widget.orderController.state.orders);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          color: Colors.black,
          child: Center(
            child: TextFormField(
              controller: controller.searchController,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    iconSize: 24,
                    icon: const Icon(Icons.search_rounded),
                    onPressed: () {
                      if (controller.searchController.text.isNotEmpty) {
                        setState(() {
                          list = SearchListOrderPage(orders: controller.filterByCpf(widget.orderController.state.orders, controller.searchController.text));
                        });
                      }
                      controller.searchController.clear();
                    },
                  ),
                  hintText: 'Pesquisar por CPF...',
                  counterText: "",
                  border: InputBorder.none),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              autofocus: true,
              enableSuggestions: true,
              maxLength: 11,
            ),
          ),
        ),
      ),
      body: list,
    );
  }
}
