import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget child;

  const MyButton({
    super.key, 
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 163 , 209, 198),
          borderRadius: BorderRadius.circular(30)
        ),
        padding: const EdgeInsets.all(25),
        child: child,
      ),
    );
  }
}
