import 'package:app_pedido/features/customers/pages/customers/controller/customer_controller.dart';
import 'package:app_pedido/features/customers/pages/list_customer_page.dart';
import 'package:app_pedido/features/customers/states/customer_state.dart';
import 'package:app_pedido/features/customers/stores/customer_store.dart';
import 'package:app_pedido/shared/components/loading_widget.dart';
import 'package:app_pedido/shared/components/start_default_widget.dart';
import 'package:app_pedido/shared/utils/navigate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final CustomerController controller = CustomerController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CustomerStore>().fetchCustomers();
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.initialize(context.watch<CustomerStore>());
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Clientes"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigate().toNewCustomerPage(context, controller);
                  },
                  icon: const Icon(Icons.add_circle_outline_rounded),
                  color: Colors.deepPurpleAccent,
                  iconSize: 32)
            ],
          ),
          body: configPage(),
        );
      },
    );
  }

  Widget configPage() {
    if (controller.state == null) {
      return const StartDefaultWidget(iconData: Icons.sentiment_satisfied_alt_outlined, title: 'Seja bem-vindo a área de clientes!', subtitle: 'comece cadastrando seu primeiro cliente...');
    }

    if (controller.state is LoadingCustomerState) {
      return const LoadingWidget();
    }

    if (controller.state is ErrorCustomerState) {
      return const StartDefaultWidget(iconData: Icons.report_problem_rounded, title: 'Algo deu errado :(', subtitle: 'tente novamente mais tarde');
    }

    if (controller.state is SuccessCustomerState && controller.state.customers.isNotEmpty) {
      return ListCustomerPage(controller: controller);
    }

    return const StartDefaultWidget(iconData: Icons.sentiment_satisfied_alt_outlined, title: 'Seja bem-vindo a área de clientes!', subtitle: 'comece cadastrando seu primeiro cliente...');
  }
}
