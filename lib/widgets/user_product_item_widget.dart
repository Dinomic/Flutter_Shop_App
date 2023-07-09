import 'package:flutter/material.dart';

import 'package:flutter_shop_app/screens/product_config_screen.dart';

class UserProductItemWidget extends StatelessWidget {
  const UserProductItemWidget({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  final int id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () => {
                Navigator.of(context)
                    .pushNamed(ProductConfigScreen.routeName, arguments: id)
              },
              icon: const Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}
