import 'package:flutter/material.dart';
import 'package:sqflite_demo/consts/app_string_consts.dart';

import '../blocs/db_bloc.dart';
import '../models/product.dart';
import '../widgets/app_text_field.dart';

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
            actions(context),
          ],
        ),
      ),
    );
  }

  Widget actions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        updateButton(context),
        deleteButton(context),
      ],
    );
  }

  ElevatedButton deleteButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          int result = await dbBloc.deleteProduct(widget.product.id ?? 0);
          if (result > 0) {
            Navigator.pop(context, true);
          }
        } catch (e) {}
      },
      child: Text(AppStrings.delete),
    );
  }

  ElevatedButton updateButton(BuildContext context) {
    return ElevatedButton(
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

        int result = await dbBloc.updateProduct(updatedProduct);
        if (result > 0) {
          Navigator.pop(context, true);
        } else {
          // Hata mesajı gösterebilirsiniz.
        }
      },
      child: Text(AppStrings.update),
    );
  }
}
