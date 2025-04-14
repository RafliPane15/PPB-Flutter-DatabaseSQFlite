import 'package:flutter/material.dart';
import 'package:flutterappexample/models/product.dart';
import 'package:flutterappexample/models/shop.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  //remove item from cart
  void removeItemFromCart(BuildContext context, Product product){
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: Text("Hapus barang ini dari keranjang?"),
            actions: [
              //cancel button
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Batalkan"),
              ),

              // yes button
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);

                  //add to cart
                  context.read<Shop>().removeItemFromCart(product);
                },
                child: const Text("Ya"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Shop>().cart;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart Page"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          // cart list
          Expanded(
            child: cart.isEmpty ? const Center(child: Text("Keranjang anda kosong")): 
              ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                //get item in cart
                final item = cart[index];

                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.price.toStringAsFixed(0)),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => removeItemFromCart(context, item),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
