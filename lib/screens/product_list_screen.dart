import 'package:flutter/material.dart';
import 'package:sqflite_demo/blocs/db_bloc.dart';
import 'package:sqflite_demo/models/product.dart';
import 'package:sqflite_demo/screens/add_product_screen.dart';
import 'package:sqflite_demo/screens/edit_product_screen.dart';

import '../consts/app_string_consts.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.productList)),
      floatingActionButton: buildFloatingActionButton(context),
      body: SafeArea(
        child: StreamBuilder(
          stream: dbBloc.getStream,
          builder: (context, snapshot) {
            return buildFutureBuilder();
          },
        ),
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductScreen()),
          );
        });
  }

  FutureBuilder<List<Product>> buildFutureBuilder() {
    return FutureBuilder(
      future: dbBloc.getAll(),
      builder: (context, snapshot) {
        List<Product> list = snapshot.data ?? [];
        return list.isNotEmpty
            ? buildListView(snapshot, list)
            : const SizedBox();
      },
    );
  }

  ListView buildListView(
      AsyncSnapshot<List<Product>> snapshot, List<Product> list) {
    return ListView.builder(
      itemCount: snapshot.data?.length,
      itemBuilder: (context, index) => Card(
        color: Colors.greenAccent,
        child: ListTile(
          title: Text(list[index].name),
          subtitle: Text(list[index].description),
          trailing: Text(list[index].price.toString()),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EditProductScreen(product: list[index])));
          },
        ),
      ),
    );
  }
}
