import 'package:flutter/material.dart';
import 'package:sqflite_demo/consts/app_string_consts.dart';

import '../data/db_helper.dart';
import '../models/product.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  EditProductScreen({required this.product});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.product.name;
    descriptionController.text = widget.product.description;
    priceController.text = widget.product.price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.editProduct),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    String name = nameController.text;
                    String description = descriptionController.text;
                    double price = double.tryParse(priceController.text) ?? 0.0;

                    Product updatedProduct = Product(
                      id: widget.product.id,
                      name: name,
                      description: description,
                      price: price,
                    );

                    int result =
                        await databaseHelper.updateProduct(updatedProduct);
                    if (result > 0) {
                      Navigator.pop(context, true);
                    } else {
                      // Hata mesajı gösterebilirsiniz.
                    }
                  },
                  child: Text(AppStrings.update),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      int result = await databaseHelper
                          .deleteProduct(widget.product.id ?? 0);
                      if (result > 0) {
                        Navigator.pop(context, true);
                      }
                    } catch (e) {}
                  },
                  child: Text(AppStrings.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}