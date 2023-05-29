import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  static String routeName = 'products/product-detail';

  @override
  Widget build(BuildContext context) {
    int chosenProductId = ModalRoute.of(context)!.settings.arguments as int;
    ProductModel chosenProduct = Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).findById(chosenProductId);

    return Scaffold(
        appBar: AppBar(
          title: Text(chosenProduct.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  chosenProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '\$${chosenProduct.price}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  chosenProduct.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              )
            ],
          ),
        ));
  }
}
