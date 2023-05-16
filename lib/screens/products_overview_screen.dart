import 'package:flutter/material.dart';
import 'package:flutter_shop_app/widgets/product_grids_widget.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavarites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Shop'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case FilterOptions.favorites:
                  setState(() {
                    _showOnlyFavarites = true;
                  });
                  break;
                case FilterOptions.all:
                  setState(() {
                    _showOnlyFavarites = false;
                  });
                  break;
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: FilterOptions.favorites,
                child: Text('OnlysFavorites'),
              ),
              PopupMenuItem(
                value: FilterOptions.all,
                child: Text('All'),
              )
            ],
          ),
        ],
      ),
      body: ProductGridsWidget(
        showOnlyFavorites: _showOnlyFavarites,
      ),
    );
  }
}
