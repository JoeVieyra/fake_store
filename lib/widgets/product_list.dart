import 'package:fake_store/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductList extends StatelessWidget {
  const ProductList(
      {super.key,
      required this.apiProvider,
      required this.scrollController,
      required this.isLoading});

  final ApiProvider apiProvider;
  final ScrollController scrollController;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      padding: const EdgeInsets.all(16),
      itemCount: isLoading
          ? apiProvider.products.length + 3
          : apiProvider.products.length,
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index < apiProvider.products.length) {
          final product = apiProvider.products[index];
          return GestureDetector(
            onTap: () {
              context.go('/details', extra: product);
            },
            child: Card(
              child: Column(
                children: [
                  Hero(
                    tag: product.id!,
                    child: FadeInImage(
                        placeholder: AssetImage('assets/images/infinito.gif'),
                        image: NetworkImage(product.image!),
                        height: 120,
                        width: 120),
                  ),
                  Text(
                    product.title!,
                    style: TextStyle(
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text("Price : ${product.price}\$")
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
