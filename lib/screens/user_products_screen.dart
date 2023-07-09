import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_shop_app/screens/product_config_screen.dart';

import 'package:flutter_shop_app/providers/products_provider.dart';

import 'package:flutter_shop_app/widgets/user_product_item_widget.dart';
import 'package:flutter_shop_app/widgets/app_drawer_widget.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({super.key});
  static const routeName = '/user-product';

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      drawer: const AppDrawerWidget(),
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(ProductConfigScreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsProvider.products.length,
          itemBuilder: (_, i) => Column(children: [
            UserProductItemWidget(
              id: productsProvider.products[i].id,
              title: productsProvider.products[i].title,
              imageUrl: productsProvider.products[i].imageUrl,
            ),
            const Divider(),
          ]),
        ),
      ),
    );
  }
}
