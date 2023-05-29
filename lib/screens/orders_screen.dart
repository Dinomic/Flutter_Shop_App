import 'package:flutter/material.dart';
import 'package:flutter_shop_app/widgets/order_item_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop_app/providers/orders_provider.dart';
import 'package:flutter_shop_app/widgets/app_drawer_widget.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: ordersProvider.orders.length,
        itemBuilder: (context, index) =>
            OrderItemWidget(orderItem: ordersProvider.orders.elementAt(index)),
      ),
      drawer: const AppDrawerWidget(),
    );
  }
}
