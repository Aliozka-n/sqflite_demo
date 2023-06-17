import 'package:flutter/material.dart';
import 'package:sqflite_demo/consts/app_string_consts.dart';
import 'package:sqflite_demo/models/product.dart';

import '../data/db_helper.dart';
import 'add_product_screen.dart';
import 'edit_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  void _getProductList() async {
    List<Product> products = await databaseHelper.getAllProducts();
    setState(() {
      productList = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.productList),
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return buildCard(index, context);
        },
      ),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  Widget buildCard(int index, BuildContext context) {
    return Card(
      color: Colors.greenAccent,
      child: ListTile(
        title: Text(productList[index].name),
        subtitle: Text(productList[index].description),
        trailing: Text(productList[index].price.toString()),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  EditProductScreen(product: productList[index]),
            ),
          ).then((value) {
            if (value != null && value) {
              _getProductList();
            }
          });
        },
      ),
    );
  }

  Widget buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddProductScreen(),
          ),
        ).then((value) {
          if (value != null && value) {
            _getProductList();
          }
        });
      },
    );
  }
}
