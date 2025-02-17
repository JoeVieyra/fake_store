import 'package:flutter/material.dart';
import 'package:fake_store/models/product_model.dart';
import 'package:fake_store/widgets/product_details_section.dart';
import 'package:fake_store/widgets/product_image.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Products products;
  const ProductDetailsScreen({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Producto'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImage(
              imageUrl: products.image!,
              tag: products.id!.toString(),
            ),
            ProductDetailsSection(product: products),
          ],
        ),
      ),
    );
  }
}
