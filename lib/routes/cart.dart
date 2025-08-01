// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/routes/product_list.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int homeAndCartNavigation = 0;
  List<Widget> bottomScreenNavigation = [
    ProductList(),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // print(cartProvider);
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: ListView.builder(
        itemCount: cartProvider.cart.length,
        itemBuilder: (context, index) {
          final cartDetails = cartProvider.cart[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                cartDetails['imageUrl'],
              ),
              radius: 40,
            ),
            title: Text(cartDetails['title']),
            subtitle: Text("Size: ${cartDetails['sizes'].toString()}"),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Delete Product',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        content: Text(
                          'Are you sure you want to remove this product from your cart?',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'No',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          TextButton(
                              onPressed: () {
                                cartProvider.removeProduct(
                                    product: cartDetails);
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    padding: EdgeInsets.all(20),
                                    showCloseIcon: true,
                                    content: Text(
                                        'Product has been removed from your cart'),
                                  ),
                                );
                              },
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ],
                      );
                    });
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}
