import 'package:app_pedido/features/customers/pages/customers/controller/customer_controller.dart';
import 'package:app_pedido/features/customers/states/customer_state.dart';
import 'package:app_pedido/features/customers/stores/customer_store.dart';
import 'package:app_pedido/features/orders/models/item_model.dart';
import 'package:app_pedido/features/orders/pages/newOrders/controller/new_order_controller.dart';
import 'package:app_pedido/features/orders/pages/orders/controller/order_controller.dart';
import 'package:app_pedido/features/products/pages/products/controller/product_controller.dart';
import 'package:app_pedido/features/products/stores/product_store.dart';
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
  final ProductController productController = ProductController();

  late String nameCustomer;

  @override
  void initState() {
    super.initState();
    controllerPage = NewOrderController(widget.orderController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CustomerStore>().fetchCustomers();
      context.read<ProductStore>().fetchProducts();
    });
    nameCustomer = '';
  }

  @override
  Widget build(BuildContext context) {
    customerController.initialize(context.watch<CustomerStore>());
    productController.initialize(context.watch<ProductStore>());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Pedido'),
        actions: [
          TextButton(
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
          const SizedBox(width: 8)
        ],
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
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Items:", style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    content: SizedBox(
                                      height: 300.0, // Change as per your requirement
                                      width: 400.0,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: productController.state.products.length,
                                        itemBuilder: (context, index) {
                                          final product = productController.state.products[index];
                                          return ListTile(
                                            leading: Text('${product.id}'),
                                            title: Text(product.description),
                                            onTap: () {
                                              setState(() {
                                                controllerPage.isSelectedProduct(ItemModel(id: 0, quantity: 0, product: product));
                                              });
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Fechar'),
                                      ),
                                    ],
                                  ));
                        },
                        child: const Text("Selecionar produtos")),
                  ],
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: controllerPage.newOrder.items.length,
                  itemBuilder: (context, index) {
                    final product = controllerPage.newOrder.items[index].product;
                    final item = controllerPage.newOrder.items[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(
                            product.description,
                            style: const TextStyle(fontSize: 16),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    if (item.quantity > 0) {
                                      setState(() {
                                        item.quantity--;
                                      });
                                    }
                                  },
                                  icon: const Icon(Icons.remove_rounded)),
                              Text(
                                '${item.quantity}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      item.quantity++;
                                    });
                                  },
                                  icon: const Icon(Icons.add_rounded)),
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  controllerPage.newOrder.items.remove(item);
                                });
                              },
                              icon: const Icon(
                                Icons.delete_rounded,
                                color: Colors.red,
                              ))
                        ]),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
