
import 'package:flutter/material.dart';

class HelpButton extends StatelessWidget {
  final VoidCallback onTap;
  final String image;
  const HelpButton({
    super.key,
    required this.onTap,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 50,
        height: 50,
        child: Image.asset("assets/images/$image.png"),
      ),
    );
  }
}
