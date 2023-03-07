import 'package:app_pedido/features/products/pages/newProducts/controller/new_product_controller.dart';
import 'package:app_pedido/features/products/pages/products/controller/product_controller.dart';
import 'package:flutter/material.dart';

class NewProductPage extends StatefulWidget {
  final ProductController controller;

  const NewProductPage({super.key, required this.controller});

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  late final NewProductController controllerPage;

  @override
  void initState() {
    super.initState();
    controllerPage = NewProductController(widget.controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Produto'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controllerPage.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: controllerPage.descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe a descrição';
                    }
                    return null;
                  },
                  maxLength: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (controllerPage.formKey.currentState!.validate()) {
                        controllerPage.createProduct().then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(widget.controller.snackBarWidget);
                        });
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
