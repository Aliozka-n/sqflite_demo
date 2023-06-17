import 'package:flutter/material.dart';
import 'package:sqflite_demo/consts/app_string_consts.dart';

import '../data/db_helper.dart';
import '../models/product.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.addProduct),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: AppStrings.productName,
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: AppStrings.productExplanation,
              ),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: AppStrings.unitPrice,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String name = nameController.text;
                String description = descriptionController.text;
                double price = double.tryParse(priceController.text) ?? 0.0;

                Product product = Product(
                  name: name,
                  description: description,
                  price: price,
                );

                int result = await databaseHelper.insertProduct(product);
                if (result > 0) {
                  Navigator.pop(context, true);
                }
              },
              child: Text(AppStrings.save),
            ),
          ],
        ),
      ),
    );
  }
}
