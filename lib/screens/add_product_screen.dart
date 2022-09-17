import 'package:dhobiaya/helper/db_helper.dart';
import 'package:dhobiaya/models/product_model.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final globalKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();

  DBHelper? dbHelper;
  @override
  void initState() {
    dbHelper = DBHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Form(
        key: globalKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter title';
                  }
                  return null;
                },
                decoration: const InputDecoration(hintText: "title"),
              ),
              TextFormField(
                controller: descController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
                decoration: const InputDecoration(hintText: "description"),
              ),
              TextFormField(
                controller: priceController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
                decoration: const InputDecoration(hintText: "price"),
              ),
             const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  if (globalKey.currentState!.validate()) {
                    var req = ProductModel(
                      title: titleController.text,
                      description: descController.text,
                      price: int.parse(priceController.text),
                    );
                    dbHelper!.insert(req).then((res) {
                      print('added');
                    });
                  }
                },
                child: const Text(
                  'ADD',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
