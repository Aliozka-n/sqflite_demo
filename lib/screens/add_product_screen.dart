import 'package:flutter/material.dart';
import 'package:sqflite_demo/consts/app_string_consts.dart';

import '../base_widgets/app_text_field.dart';
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
            AppTextField(
                controller: nameController, labelText: AppStrings.productName),
            AppTextField(
                controller: descriptionController,
                labelText: AppStrings.productExplanation),
            AppTextField(
                controller: priceController,
                labelText: AppStrings.unitPrice,
                isNumber: true),
            SizedBox(height: 16.0),
            action(context),
          ],
        ),
      ),
    );
  }

  Widget action(BuildContext context) {
    return ElevatedButton(
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
    );
  }
}
