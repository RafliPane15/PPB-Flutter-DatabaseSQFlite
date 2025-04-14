import 'package:flutter/material.dart';
import 'package:flutterappexample/components/list.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // header
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.shopping_bag,
                    size: 72,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // shop tile
              MyListTile(
                text: "Home",
                icon: Icons.home,
                onTap: () => Navigator.pop(context),
              ),

              // cart tile
              MyListTile(
                text: "Keranjang",
                icon: Icons.shopping_cart,
                onTap: () {
                  Navigator.pop(context);

                  Navigator.pushNamed(context, '/cartpage');
                },
              ),

            ],
          ),
              // exit
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: MyListTile(
                  text: "Keluar",
                  icon: Icons.exit_to_app_rounded,
                  onTap: () => Navigator.pushNamed(context, '/homepage'),
                ),
              ),
        ],
      ),
    );
  }
}
