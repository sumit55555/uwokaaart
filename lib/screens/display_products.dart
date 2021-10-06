
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:uwokart/screens/ProductCard.dart';
import 'package:uwokart/services/appbar_title.dart';
import 'package:uwokart/services/cart_nav.dart';
import 'package:uwokart/tabs/SearchPage.dart';

class DisplayProducts extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection('Images');
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppbarTitle(),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(),
                  ),
                );
              },
              child: Image(
                image: AssetImage('assets/images/search_icon.png'),
                width: 18.0,
                height: 18.0,
                color: Colors.white,
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(right: 10.0, left: 10.0),
              child: CartNav()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
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
                    childAspectRatio: (itemWidth / 250),
                    physics: BouncingScrollPhysics(),
                    children: snapshot.data!.docs.map((document) {
                      return ProductCard(
                        name: document.data()['name'],
                        price: document.data()['price'],
                        rating: document.data()['rating'],
                        image: document.data()['images'][0],
                        productId: document.id,
                      );
                    }).toList(),
                  );
                }

                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
