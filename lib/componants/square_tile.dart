import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final Function()? onTap;
  final String imagePath;
  const SquareTile({
    super.key,
    required this.imagePath,
    required this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 225, 224, 224)),
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[200],
          ),
        height: 60,
        child: Image.asset(imagePath),
    ),
    );
  }
}