import 'package:app_pedido/features/products/pages/products/controller/product_controller.dart';
import 'package:app_pedido/features/products/pages/products/list_product.dart';
import 'package:app_pedido/features/products/states/product_state.dart';
import 'package:app_pedido/features/products/stores/product_store.dart';
import 'package:app_pedido/shared/components/loading_widget.dart';
import 'package:app_pedido/shared/components/start_default_widget.dart';
import 'package:app_pedido/shared/utils/navigate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductController controller = ProductController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductStore>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.initialize(context.watch<ProductStore>());
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Produtos"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigate().toNewProductPage(context, controller);
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
      return const StartDefaultWidget(iconData: Icons.add_shopping_cart_rounded, title: 'Seja bem-vindo a área de produtos!', subtitle: 'comece cadastrando seu primeiro produto...');
    }

    if (controller.state is LoadingProductState) {
      return const LoadingWidget();
    }

    if (controller.state is ErrorProductState) {
      return const StartDefaultWidget(iconData: Icons.report_problem_rounded, title: 'Algo deu errado :(', subtitle: 'tente novamente mais tarde');
    }

    if (controller.state is SuccessProductState && controller.state.products.isNotEmpty) {
      return ListProduct(controller: controller);
    }

    return const StartDefaultWidget(iconData: Icons.add_shopping_cart_rounded, title: 'Seja bem-vindo a área de produtos!', subtitle: 'comece cadastrando seu primeiro produto...');
  }
}
