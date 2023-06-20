import 'dart:async';

import '../data/db_helper.dart';
import '../models/product.dart';

class DbBloc {
  final dbStreamController = StreamController.broadcast();

  Stream get getStream => dbStreamController.stream;

  Future<int> insertProduct(Product product) async {
    int a = await DatabaseHelper.instance.insertProduct(product);
    dbStreamController.sink.add(DatabaseHelper.instance.getAllProducts());
    return a;
  }

  Future<int> updateProduct(Product product) async {
    int a = await DatabaseHelper.instance.updateProduct(product);
    dbStreamController.sink.add(DatabaseHelper.instance.getAllProducts());
    return a;
  }

  Future<int> deleteProduct(int id) async {
    int a = await DatabaseHelper.instance.deleteProduct(id);
    dbStreamController.sink.add(DatabaseHelper.instance.getAllProducts());
    return a;
  }

  Future<List<Product>> getAll() {
    return DatabaseHelper.instance.getAllProducts();
  }
}

final dbBloc = DbBloc();
