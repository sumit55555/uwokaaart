
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uwokart/screens/ShowHomeProducts.dart';
import 'package:uwokart/services/appbar_title.dart';
import 'package:uwokart/services/cart_nav.dart';
import 'package:uwokart/services/firebase_services.dart';
import 'package:uwokart/services/profile_icon.dart';
import 'package:uwokart/tabs/SearchPage.dart';

class SavedPage extends StatelessWidget {
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
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
            child: CartNav(),
          ),
          ProfileIcon(),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.usersRef
                .doc(_firebaseServices.getUserId())
                .collection("Saved")
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              // Collection Data ready to display
              if (snapshot.connectionState == ConnectionState.done) {
                // Display the data inside a list view
                return ListView(
                  padding: EdgeInsets.only(
                    bottom: 12.0,
                  ),
                  children: snapshot.data!.docs.map((document) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowHomeProducts(
                              productId: document.id,
                            ),
                          ),
                        );
                      },
                      child: FutureBuilder(
                        future:
                            _firebaseServices.blogsRef.doc(document.id).get(),
                        builder: (context, productSnap) {
                          if (productSnap.hasError) {
                            return Container(
                              child: Center(
                                child: Text("${productSnap.error}"),
                              ),
                            );
                          }

                          if (productSnap.connectionState ==
                              ConnectionState.done) {
                            Map _productMap = productSnap.data!.data();

                            return Card(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10.0),
                                        width: 3 *
                                            (MediaQuery.of(context).size.width /
                                                5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${_productMap['name']}",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 18.0),
                                              child: Text(
                                                'Seller: CottonCraft',
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Text(
                                                "\$${_productMap['price']}",
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 6,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                "Rating - ${_productMap['rating']}",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0),
                                        margin:
                                            const EdgeInsets.only(right: 10.0),
                                        width: 120.0,
                                        child: Card(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              "${_productMap['image']}",
                                              // fit: BoxFit.cover,
                                              height: 100.0,
                                              width: 100,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: Color(0xffdcdcdc),
                                        ),
                                      ),
                                    ),
                                    margin: EdgeInsets.only(
                                      top: 10.0,
                                      bottom: 5.0,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'Delivery by 4 days 2021 | Free Delivery'),
                                  ),
                                ],
                              ),
                            );
                          }

                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              }

              // Loading State
              return Scaffold(
                body: Center(
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
