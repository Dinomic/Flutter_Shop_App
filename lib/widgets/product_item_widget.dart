import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop_app/screens/product_details_screen.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/providers/cart_provider.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ProductModel product = Provider.of<ProductModel>(context, listen: false);
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          leading: Consumer<ProductModel>(
            // using consumer to just rebuild this specific widget when
            // provider changes data
            builder: (context, product, child) => IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              color: Theme.of(context).primaryColorLight,
              onPressed: () {
                product.toggleFavorite();
              },
              // child can be referenced from Consumer.child and is not re-reder
            ),
            // child: someWidget
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).primaryColorLight,
            onPressed: () {
              cartProvider.addItem(product.id, product.title, product.price);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Item added!',
                  ),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cartProvider.removeSingleItem(product.id);
                      }),
                ),
              );
            },
          ),
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailsScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(product.imageUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
