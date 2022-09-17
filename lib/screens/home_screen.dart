import 'package:dhobiaya/helper/db_helper.dart';
import 'package:dhobiaya/models/product_model.dart';
import 'package:dhobiaya/screens/add_product_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          centerTitle: true,
          title: const Text('Home Screen'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddProductScreen()));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              dbHelper!.getProducts();
            });
          },
          child: FutureBuilder<List<ProductModel>>(
              future: dbHelper!.getProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(snapshot.data![index].title.toString()),
                            subtitle: Text(
                                snapshot.data![index].description.toString()),
                            trailing:
                                Text(snapshot.data![index].price.toString()),
                          ),
                        );
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ));
  }
}
