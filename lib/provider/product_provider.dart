import 'package:fake_store/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum ApiStatus {
  initial,
  loading,
  loaded,
  error,
}

class ApiProvider with ChangeNotifier {
  final _baseUrl = "fakestoreapi.com";
  List<Products> products = [];
  ApiStatus _status = ApiStatus.initial; // Estado actual
  String _errorMessage = ''; // Mensaje de error

  ApiStatus get status => _status;
  String get errorMessage => _errorMessage;
  bool get isLoading => _status == ApiStatus.loading;

  Future<void> getProducts(int page) async {
    if (_status == ApiStatus.loading) return;

    try {
      _status = ApiStatus.loading;

      final result = await http.get(Uri.https(_baseUrl, "/products", {
        'page': page.toString(),
      }));

      if (result.statusCode == 200) {
        try {
          final response = productsFromJson(result.body);
          products.addAll(response);
          notifyListeners();
          _status = ApiStatus.loaded;
          _errorMessage = '';
        } catch (e) {
          _status = ApiStatus.error;
          _errorMessage = 'Error al procesar los datos';
        }
      } else {
        _status = ApiStatus.error;
        _errorMessage = 'Error del servidor: ${result.statusCode}';
      }
    } catch (e) {
      _status = ApiStatus.error;
      _errorMessage = 'Error de conexión';
    }
  }
}
