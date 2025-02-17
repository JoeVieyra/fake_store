import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final String tag;

  const ProductImage({super.key, required this.imageUrl, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag, // Aquí ya es un String
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: FadeInImage(
          placeholder: const AssetImage('assets/images/infinito.gif'),
          image: NetworkImage(imageUrl),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
