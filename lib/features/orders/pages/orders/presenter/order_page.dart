import 'package:app_pedido/features/orders/pages/listOrders/presenter/list_order_page.dart';
import 'package:app_pedido/features/orders/pages/orders/controller/order_controller.dart';
import 'package:app_pedido/features/orders/states/order_state.dart';
import 'package:app_pedido/features/orders/stores/order_store.dart';
import 'package:app_pedido/shared/components/drawer_widget.dart';
import 'package:app_pedido/shared/components/loading_widget.dart';
import 'package:app_pedido/shared/components/start_default_widget.dart';
import 'package:app_pedido/shared/utils/navigate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final OrderController controller = OrderController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderStore>().fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.initialize(context.watch<OrderStore>());
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Pedidos"),
            actions: [
              IconButton(
                  onPressed: () {
                    if (controller.state.orders.length > 0) {
                      Navigate().toSearchOrderPage(context, controller);
                    }
                  },
                  icon: const Icon(Icons.search_rounded),
                  color: Colors.deepPurpleAccent,
                  iconSize: 32)
            ],
          ),
          drawer: const DrawerWidget(),
          body: configPage(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigate().toNewOrderPage(context, controller);
            },
            tooltip: 'Novo pedido',
            child: const Icon(Icons.add_rounded),
          ),
        );
      },
    );
  }

  Widget configPage() {
    if (controller.state == null) {
      return const StartDefaultWidget(iconData: Icons.shopping_bag_outlined, title: 'Seja bem-vindo a área de pedidos!', subtitle: 'comece cadastrando seu primeiro pedido...');
    }

    if (controller.state is LoadingOrderState) {
      return const LoadingWidget();
    }

    if (controller.state is ErrorOrderState) {
      return const StartDefaultWidget(iconData: Icons.report_problem_rounded, title: 'Algo deu errado :(', subtitle: 'tente novamente mais tarde');
    }

    if (controller.state is SuccessOrderState && controller.state.orders.isNotEmpty) {
      return ListOrderPage(controller: controller);
    }

    return const StartDefaultWidget(iconData: Icons.shopping_bag_outlined, title: 'Seja bem-vindo a área de pedidos!', subtitle: 'comece cadastrando seu primeiro pedido...');
  }
}
