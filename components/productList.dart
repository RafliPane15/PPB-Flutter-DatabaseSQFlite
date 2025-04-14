import 'package:flutter/material.dart';
import 'package:flutterappexample/models/product.dart';
import 'package:flutterappexample/models/shop.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  final Product product;

  const ProductList({super.key, required this.product});

  // cart button pressed
  void addItemToCart(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Text("Tambahkan ke keranjang?"),
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
                  context.read<Shop>().addItemToCart(product);
                },
                child: const Text("Ya"),
              ),
            ],
          ),
    );
  }

  // edit description
  void editDescription(BuildContext context) {
    TextEditingController descriptionController = TextEditingController(text: product.description);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Edit Deskripsi"),
            content: TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Deskripsi"),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Batal"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<Shop>().updateProductDescription(product, descriptionController.text);
                  Navigator.pop(context);
                },
                child: const Text("Simpan"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(13),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(30),
      width: 300,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                //product image
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(25),
                    child: Image.asset(product.imagePath),
                  ),
                ),

                const SizedBox(height: 25),

                //product name
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(height: 15),

                //product description
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product.description,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => editDescription(context),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),
            //product price + add to cart
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\Rp ' + product.price.toStringAsFixed(0)),

                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  //cart button
                  child: IconButton(
                    onPressed: () => addItemToCart(context),
                    icon: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
