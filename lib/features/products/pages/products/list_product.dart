import 'package:app_pedido/features/products/pages/products/controller/product_controller.dart';
import 'package:flutter/material.dart';

class ListProduct extends StatefulWidget {
  final ProductController controller;

  const ListProduct({super.key, required this.controller});

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.controller.state.products.length,
        itemBuilder: (context, index) {
          final product = widget.controller.state.products[index];

          return ListTile(
            leading: Text('${product.id}', style: const TextStyle(fontSize: 14)),
            title: Text(product.description),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 140,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${product.description}", style: const TextStyle(fontSize: 24)),
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
                    widget.controller.initFormEdit(product.description),
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Editar Produto'),
                        content: SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: Form(
                            key: widget.controller.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  controller: widget.controller.descriptionController,
                                  decoration: const InputDecoration(
                                    labelText: 'Descrição',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, informe a descrição';
                                    }
                                    if (value == product.description && widget.controller.isDescriptionEdited == false) {
                                      return 'Informe uma descrição diferente';
                                    } else {
                                      widget.controller.isDescriptionEdited = true;
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
                                widget.controller.editProduct(product.id, widget.controller.descriptionController.text).then((value) {
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
                        title: const Text('Excluir Produto'),
                        content: const Text('Tem certeza que deseja excluir esse produto?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Não'),
                            child: const Text('Não'),
                          ),
                          TextButton(
                            onPressed: () {
                              widget.controller.deleteProduct(product).then((value) {
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
