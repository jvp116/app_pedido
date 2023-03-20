import 'package:app_pedido/features/orders/pages/newOrders/controller/new_order_controller.dart';
import 'package:app_pedido/features/orders/pages/orders/controller/order_controller.dart';
import 'package:flutter/material.dart';

class NewOrderPage extends StatefulWidget {
  final OrderController controller;

  const NewOrderPage({super.key, required this.controller});

  @override
  State<NewOrderPage> createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage> {
  late final NewOrderController controllerPage;

  @override
  void initState() {
    super.initState();
    controllerPage = NewOrderController(widget.controller);
  }

  @override
  Widget build(BuildContext context) {
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
                // TextFormField(
                //   controller: controllerPage.cpfController,
                //   decoration: const InputDecoration(
                //     labelText: 'CPF',
                //   ),
                //   // validator: widget.controller.validateCPF,
                //   keyboardType: TextInputType.number,
                //   inputFormatters: [
                //     FilteringTextInputFormatter.digitsOnly,
                //     CpfInputFormatter()
                //   ],
                // ),
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
