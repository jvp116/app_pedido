import 'package:app_pedido/components/loading_widget.dart';
import 'package:app_pedido/components/start_default_widget.dart';
import 'package:app_pedido/features/products/states/product_state.dart';
import 'package:app_pedido/features/products/stores/product_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductStore>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<ProductStore>();
    final state = store.value;
    Widget child = const StartDefaultWidget(
        iconData: Icons.add_shopping_cart_rounded,
        title: 'Seja bem-vindo a área de produtos!',
        subtitle: 'comece cadastrando seu primeiro produto...');

    if (state is LoadingProductState) {
      child = const LoadingWidget();
    }

    if (state is ErrorProductState) {
      child = const StartDefaultWidget(
          iconData: Icons.report_problem_rounded,
          title: 'Algo deu errado :(',
          subtitle: 'tente novamente mais tarde');
    }

    if (state is SuccessProductState && state.products.isNotEmpty) {
      child = ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: state.products.length,
        itemBuilder: (context, index) {
          final product = state.products[index];

          return ListTile(
            leading:
                Text('${product.id}', style: const TextStyle(fontSize: 14)),
            title: Text(product.description),
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
                          Text("${product.id} - ${product.description}",
                              style: const TextStyle(fontSize: 24)),
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
              color: Colors.purple,
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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Editar Produto'),
                        content: const Row(
                          children: [
                            Text('Form edit'),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancelar'),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Salvar'),
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
                        content: const Text(
                            'Tem certeza que deseja excluir esse produto?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Não'),
                            child: const Text('Não'),
                          ),
                          TextButton(
                            onPressed: () {
                              store.service.deleteProduct(product.id);
                              setState(() {
                                state.products.remove(product);
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
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Produtos"),
      ),
      body: child,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => CustomerAdd(),
          //   ),
          // );
        },
        tooltip: 'Novo produto',
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
