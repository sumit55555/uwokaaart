
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uwokart/screens/HomeProductsCart.dart';

class HomeProducts extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection('Blogs');
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;

    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                // display data in listvie
                return GridView.count(
                  controller: new ScrollController(keepScrollOffset: false),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: (itemWidth / 270),
                  physics: BouncingScrollPhysics(),
                  children: snapshot.data!.docs.map((document) {
                    return HomeProductCard(
                      name: document.data()['name'],
                      price: document.data()['price'],
                      rating: document.data()['rating'],
                      image: document.data()['image'],
                      productId: document.id,
                    );
                  }).toList(),
                );
              }

              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
