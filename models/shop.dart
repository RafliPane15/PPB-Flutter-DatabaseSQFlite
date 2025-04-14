import 'package:flutter/material.dart';
import 'package:flutterappexample/models/product.dart';
import 'package:flutterappexample/database/database_helper.dart';

class Shop extends ChangeNotifier {
  List<Product> _shop = [];

  List<Product> get shop => _shop;
  final List<Product> _cart = [];
  List<Product> get cart => _cart;

  Shop() {
    _loadProductsFromDB();
  }

  Future<void> _loadProductsFromDB() async {
    _shop = await DatabaseHelper.instance.fetchAllProducts();

    // Tambahkan produk dummy jika database kosong
    if (_shop.isEmpty) {
      _shop = [
        Product(
          name: 'Apple Watch',
          price: 5000000,
          description: "Apple From Mount Fuji",
          imagePath: 'lib/assets/applewatch.jpeg',
        ),
        Product(
          name: 'Lenovo Legion',
          price: 26000000,
          description: "Gaming Laptop",
          imagePath: 'lib/assets/LenovoLegion.jpeg',
        ),
      ];

      for (var p in _shop) {
        await DatabaseHelper.instance.insertProduct(p);
      }
    }

    notifyListeners();
  }

  void addItemToCart(Product item) {
    _cart.add(item);
    notifyListeners();
  }

  void removeItemFromCart(Product item) {
    _cart.remove(item);
    notifyListeners();
  }

  void addProduct(String name, double price, String description, {String imagePath = "lib/assets/applewatch.jpeg"}) async {
    final newProduct = Product(
      name: name,
      price: price,
      description: description,
      imagePath: imagePath,
    );

    await DatabaseHelper.instance.insertProduct(newProduct);
    _shop = await DatabaseHelper.instance.fetchAllProducts();
    notifyListeners();
  }

  void updateProductDescription(Product product, String newDescription) async {
  final index = _shop.indexWhere((p) => p.id == product.id);
  if (index != -1) {
    final updatedProduct = product.copyWith(description: newDescription);

    await DatabaseHelper.instance.updateProduct(updatedProduct);

    _shop[index] = updatedProduct;
    notifyListeners();
  }
  }

}
