import 'package:flutter/material.dart';
import 'package:flutter_shop_app/widgets/product_grids_widget.dart';
import 'package:flutter_shop_app/widgets/badge_widget.dart';
import 'package:flutter_shop_app/widgets/app_drawer_widget.dart';
import 'package:flutter_shop_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop_app/screens/cart_screen.dart';

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
          Consumer<CartProvider>(
            builder: (context, cart, ch) => BadgeWidget(
              value: cart.itemCount.toString(),
              child: ch,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () =>
                  {Navigator.of(context).pushNamed(CartScreen.routeName)},
            ),
          ),
        ],
      ),
      drawer: const AppDrawerWidget(),
      body: ProductGridsWidget(
        showOnlyFavorites: _showOnlyFavarites,
      ),
    );
  }
}
