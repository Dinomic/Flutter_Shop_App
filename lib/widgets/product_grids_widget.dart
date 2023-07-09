import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter_shop_app/widgets/product_item_widget.dart';
import 'package:flutter_shop_app/models/product_model.dart';

class ProductGridsWidget extends StatelessWidget {
  const ProductGridsWidget({
    super.key,
    required this.showOnlyFavorites,
  });
  final bool showOnlyFavorites;

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final List<ProductModel> toDisplayProducts;
    if (showOnlyFavorites) {
      toDisplayProducts = productsProvider.getFavoriteProducts;
    } else {
      toDisplayProducts = productsProvider.products;
    }

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: toDisplayProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        // using ChangeNotifierProvider.value(value:) is recomended in case of list/grid like this
        // another approach is ChangeNotifierProvider(builder:)
        value: toDisplayProducts.elementAt(index),
        child: const ProductItemWidget(),
      ),
    );
  }
}
