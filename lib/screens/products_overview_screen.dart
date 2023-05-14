import 'package:flutter/material.dart';
import 'package:flutter_shop_app/widgets/product_grids_widget.dart';

class ProductsOverviewScreen extends StatelessWidget {
  ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Shop'),
      ),
      body: ProductGridsWidget(),
    );
  }
}
