import 'package:app_pedido/features/customers/pages/customers/controller/customer_controller.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class ListCustomerPage extends StatefulWidget {
  final CustomerController controller;

  const ListCustomerPage({super.key, required this.controller});

  @override
  State<ListCustomerPage> createState() => _ListCustomerPageState();
}

class _ListCustomerPageState extends State<ListCustomerPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.controller.state.customers.length,
        itemBuilder: (context, index) {
          final customer = widget.controller.state.customers[index];

          return ListTile(
            leading: Text('${customer.id}', style: const TextStyle(fontSize: 14)),
            title: Text(customer.name),
            subtitle: Text(customer.lastname),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 160,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${customer.name} ${customer.lastname}", style: const TextStyle(fontSize: 24)),
                          const SizedBox(height: 16),
                          Text(UtilBrasilFields.obterCpf(customer.cpf), style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            child: const Text('Fechar'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            trailing: PopupMenuButton(
              color: Colors.deepPurpleAccent,
              icon: const Icon(Icons.more_vert_rounded),
              itemBuilder: (context) => [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Editar",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(Icons.edit_rounded)
                    ],
                  ),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Excluir",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(Icons.delete_rounded)
                    ],
                  ),
                ),
              ],
              onSelected: (item) => {
                if (item == 0)
                  {
                    widget.controller.initFormEdit(customer.name, customer.lastname),
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Editar Cliente'),
                        content: SizedBox(
                          width: double.infinity,
                          height: 170,
                          child: Form(
                            key: widget.controller.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  controller: widget.controller.nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Nome',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, informe o nome';
                                    }
                                    if (value == customer.name && widget.controller.isNameEdited == false && widget.controller.isLastnameEdited == false) {
                                      return 'Informe um nome diferente';
                                    } else {
                                      widget.controller.isNameEdited = true;
                                    }
                                    return null;
                                  },
                                  maxLength: 30,
                                ),
                                TextFormField(
                                  controller: widget.controller.lastnameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Sobrenome',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, informe o sobrenome';
                                    }
                                    if (value == customer.lastname && widget.controller.isLastnameEdited == false && widget.controller.isNameEdited == false) {
                                      return 'Informe um sobrenome diferente';
                                    } else {
                                      widget.controller.isLastnameEdited = true;
                                    }
                                    return null;
                                  },
                                  maxLength: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              widget.controller.clearForm();
                              Navigator.pop(context, 'Cancelar');
                            },
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              if (widget.controller.formKey.currentState!.validate()) {
                                widget.controller.editCustomer(customer.id, widget.controller.nameController.text, widget.controller.lastnameController.text).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(widget.controller.isSuccess());
                                });
                                widget.controller.clearForm();
                                Navigator.pop(context, 'Salvar');
                              }
                            },
                            child: const Text('Salvar'),
                          ),
                        ],
                      ),
                    )
                  }
                else if (item == 1)
                  {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Excluir Cliente'),
                        content: const Text('Tem certeza que deseja excluir esse cliente?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Não'),
                            child: const Text('Não'),
                          ),
                          TextButton(
                            onPressed: () {
                              widget.controller.deleteCustomer(customer).then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(widget.controller.isSuccess());
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('Sim'),
                          ),
                        ],
                      ),
                    )
                  }
              },
            ),
          );
        },
      ),
    );
  }
}
