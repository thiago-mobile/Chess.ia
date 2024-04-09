import 'package:flutter/material.dart';

class DeadPiece extends StatelessWidget {
  final String imagePath;
  final bool iswhite;

  const DeadPiece({super.key, required this.imagePath, required this.iswhite});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      color: iswhite ? Colors.white : Colors.black,
    );
  }
}
