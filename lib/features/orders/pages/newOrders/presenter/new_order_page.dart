import 'package:app_pedido/features/customers/pages/customers/controller/customer_controller.dart';
import 'package:app_pedido/features/customers/states/customer_state.dart';
import 'package:app_pedido/features/customers/stores/customer_store.dart';
import 'package:app_pedido/features/orders/pages/newOrders/controller/new_order_controller.dart';
import 'package:app_pedido/features/orders/pages/orders/controller/order_controller.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class NewOrderPage extends StatefulWidget {
  final OrderController orderController;

  const NewOrderPage({super.key, required this.orderController});

  @override
  State<NewOrderPage> createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage> {
  late final NewOrderController controllerPage;

  final CustomerController customerController = CustomerController();

  late String nameCustomer;

  @override
  void initState() {
    super.initState();
    controllerPage = NewOrderController(widget.orderController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CustomerStore>().fetchCustomers();
    });

    nameCustomer = '';
  }

  @override
  Widget build(BuildContext context) {
    customerController.initialize(context.watch<CustomerStore>());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Pedido'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controllerPage.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Cliente: $nameCustomer", style: const TextStyle(fontSize: 18), textAlign: TextAlign.center),
                const SizedBox(height: 8),
                TextFormField(
                  controller: controllerPage.cpfController,
                  decoration: InputDecoration(
                      labelText: 'CPF',
                      suffixIcon: IconButton(
                          onPressed: () {
                            if (customerController.state is SuccessCustomerState && customerController.state.customers.isNotEmpty && controllerPage.formKey.currentState!.validate()) {
                              controllerPage.findCustomer(customerController.state.customers);
                              ScaffoldMessenger.of(context).showSnackBar(controllerPage.isFind());
                              setState(() {
                                nameCustomer = '${controllerPage.newOrder.customer.name} ${controllerPage.newOrder.customer.lastname}';
                              });
                            }
                          },
                          icon: const Icon(Icons.search_rounded, color: Colors.white))),
                  validator: widget.orderController.validateCPF,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter()
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (controllerPage.formKey.currentState!.validate()) {
                        // controllerPage.createCustomer().then((value) {
                        //   ScaffoldMessenger.of(context).showSnackBar(widget.controller.isSuccess());
                        // });
                        Navigator.pop(context);
                      }
                    },
                    child: const Center(child: Text('Cadastrar')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
