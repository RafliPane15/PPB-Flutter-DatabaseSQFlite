import 'package:flutter/material.dart';
import 'package:flutterappexample/components/button.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Icon(
              Icons.shopping_bag,
              size: 72,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),

            const SizedBox(height: 25),

            Text(
              "Mike Shop",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ), 
            ),

            const SizedBox(height: 10),

            Text(
              "Menjual Barang Berkualitas",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            
            ),

            const SizedBox(height: 25),

            // button
            MyButton(onTap: () => Navigator.pushNamed(context, '/shoppage'), 
            child: const Icon(Icons.arrow_forward))
          ],
        ),
      ),
    );
  }
}
