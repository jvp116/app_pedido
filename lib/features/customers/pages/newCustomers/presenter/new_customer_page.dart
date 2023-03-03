import 'package:app_pedido/features/customers/pages/customers/controller/customer_controller.dart';
import 'package:app_pedido/features/customers/pages/newCustomers/controller/new_customer_controller.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewCustomerPage extends StatefulWidget {
  final CustomerController controller;

  const NewCustomerPage({super.key, required this.controller});

  @override
  State<NewCustomerPage> createState() => _NewCustomerPageState();
}

class _NewCustomerPageState extends State<NewCustomerPage> {
  late final NewCustomerController controllerPage;

  @override
  void initState() {
    super.initState();
    controllerPage = NewCustomerController(widget.controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Cliente'),
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
                  controller: controllerPage.cpfController,
                  decoration: const InputDecoration(
                    labelText: 'CPF',
                  ),
                  validator: widget.controller.validateCPF,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter()
                  ],
                ),
                TextFormField(
                  controller: controllerPage.nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe o nome';
                    }
                    return null;
                  },
                  maxLength: 30,
                ),
                TextFormField(
                  controller: controllerPage.lastnameController,
                  decoration: const InputDecoration(
                    labelText: 'Sobrenome',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe o sobrenome';
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
                        controllerPage.createCustomer().then((value) {
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
