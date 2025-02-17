import 'package:fake_store/models/product_model.dart';
import 'package:fake_store/provider/product_provider.dart';
import 'package:fake_store/screens/home_screen.dart';
import 'package:fake_store/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

final GoRouter _router = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomeScreen();
      },
      routes: [
        GoRoute(
          path: 'details',
          builder: (context, state) {
            final products = state.extra as Products;
            return ProductDetailsScreen(
              products: products,
            );
          },
        )
      ])
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApiProvider(),
      child: MaterialApp.router(
        title: 'Fake Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}
