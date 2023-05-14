import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:flutter_shop_app/screens/products_overview_screen.dart';
import 'package:flutter_shop_app/screens/product_details_screen.dart';

void main() => runApp(const MyShopApp());

class MyShopApp extends StatelessWidget {
  const MyShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // using ChangeNotifierProvider(builder:) is recomended in case single widget like this
      // another approach is ChangeNotifierProvider.value(value:)
      create: (context) => ProductsProvider(),
      child: MaterialApp(
        title: 'The Shop',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          accentColor: Colors.tealAccent,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
        },
      ),
    );
  }
}
