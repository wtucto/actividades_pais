import 'package:actividades_pais/src/views/model/product_model.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  Details({
    Key? key,
    required this.productDetails,
  }) : super(key: key);

  ProductDetails productDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(4.0),
        child: ListView(
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.0, color: Colors.grey.shade300),
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Colors.deepPurpleAccent,
                ),
                onPressed: () {},
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  productDetails.isTopProduct
                      ? const Chip(
                          label: Text("Top Product"),
                          backgroundColor: Colors.deepPurple,
                          labelStyle: TextStyle(color: Colors.white))
                      : const Text(""),
                  Text(
                    productDetails.productName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  Text(productDetails.productDetails),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(primary: Colors.purple),
                        child: Text(
                          productDetails.productSIze,
                          style: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10.0)),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(primary: Colors.purple),
                        child: Text(
                          productDetails.productType.name,
                          style: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
