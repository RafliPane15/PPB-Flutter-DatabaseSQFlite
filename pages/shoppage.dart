import 'package:flutter/material.dart';
import 'package:flutterappexample/components/drawer.dart';
import 'package:flutterappexample/components/productList.dart';
import 'package:flutterappexample/models/shop.dart';
import 'package:provider/provider.dart';

class Shoppage extends StatelessWidget {
  const Shoppage({super.key});

  void createProduct(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Tambah Produk Baru"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Nama Produk"),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: "Harga"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Deskripsi"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final price = double.tryParse(priceController.text) ?? 0;
                final description = descriptionController.text;
                if (name.isNotEmpty && price > 0) {
                  Provider.of<Shop>(
                    context,
                    listen: false,
                  ).addProduct(name, price, description);
                }
                Navigator.pop(context);
              },
              child: const Text("Tambah"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //akses produk
    final products = context.watch<Shop>().shop;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mike Shop"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => Navigator.pushNamed(context, '/cartpage'),
          ),
        ],
      ),
      drawer: MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Text(
              "Pilihlah produk yang anda inginkan",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),

          SizedBox(
            height: 550,
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                // get each individual product
                final product = products[index];
                //return product UI
                return ProductList(product: product);
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => createProduct(context),
              child: const Text("Tambah Produk"),
            ),
          ),
        ],
      ),
    );
  }
}
