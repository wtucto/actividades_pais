import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MainState();
}

class _MainState extends State<Home> {
  final _productController = TextEditingController();
  final _productDesController = TextEditingController();
  final _productSizeList = ["Small", "Mediun", "Large", "XLarge"];

  List<String> producs = ["producto 1", "Producto 2", "producto 3"];
  List<String> productDetails = [
    "producto 1 All 2",
    "Producto 2 All 2",
    "producto 3 All 3"
  ];
  List<int> price = [300, 2500, 2860];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Navigation Drawer")),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountEmail: Text("support@gmail.com"),
              accountName: Text("Coding With Tea"),
              currentAccountPicture: CircleAvatar(
                  foregroundImage: AssetImage('assets/Monitor/logo.png')),
            ),
            ListTile(
                leading: Icon(Icons.home), title: Text("Home"), onTap: () {}),
            ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text("Shop"),
                onTap: () {}),
            ListTile(
                leading: Icon(Icons.favorite),
                title: Text("Favorites"),
                onTap: () {}),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text("Labels"),
            ),
            ListTile(
                leading: Icon(Icons.label), title: Text("Red"), onTap: () {}),
            ListTile(
                leading: Icon(Icons.label), title: Text("Grenn"), onTap: () {}),
            ListTile(
                leading: Icon(Icons.label), title: Text("Blue"), onTap: () {}),
          ],
        ),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: producs.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(child: Text(producs[index][0])),
                title: Text(producs[index]),
                subtitle: Text(productDetails[index]),
                trailing: Text(price[index].toString()),
              );
            }),
      ),
    );
  }
}
