

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uwokart/screens/tabs/show_comment.dart';
import 'package:uwokart/services/appbar_title.dart';
import 'package:uwokart/services/cart_nav.dart';
import 'package:uwokart/services/firebase_services.dart';
import 'package:uwokart/services/profile_icon.dart';
import 'package:uwokart/tabs/SearchPage.dart';
import 'package:uwokart/widgets/comment_input.dart';

class ShowHomeProducts extends StatefulWidget {
  final String productId;
  bool _registerFormLoading = false;

  ShowHomeProducts({required this.productId});

  @override
  _ShowHomeProductsState createState() => _ShowHomeProductsState();
}

class _ShowHomeProductsState extends State<ShowHomeProducts> {
  final databaseReference = FirebaseFirestore.instance;

  FirebaseServices _firebaseServices = FirebaseServices();

  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection('Blogs');

  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("users");

  final User _user = FirebaseAuth.instance.currentUser;

  String _selectedProductPrice = "0";

  Future _addToCart() {
    setState(() {
      widget._registerFormLoading = false;
    });

    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"price": _selectedProductPrice});

    setState(() {
      widget._registerFormLoading = true;
    });
  }

  Future _addToSaved() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Saved")
        .doc(widget.productId)
        .set({"size": _selectedProductPrice});
  }

  final SnackBar _snackBarAddToCard =
      SnackBar(content: Text('Product added to the Cart'));

  final SnackBar _snackBarAddToSaved =
      SnackBar(content: Text('Product added to the Saved'));

  Future _saveComment() {
    Map<String, String> commentMap = {
      "commentBody": _addComment,
      "commentUserId": _user.email,
    };
    databaseReference
        .collection("Blogs")
        .doc(widget.productId)
        .collection('Comments')
        .add(commentMap)
        .then((results) {
      Navigator.pop(context);
    });
  }

  String _addComment = '';

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
          FutureBuilder(
            future: _productRef.doc(widget.productId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                // Firebase Document Data Map
                Map<String, dynamic> documentData = snapshot.data!.data();

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListView(
                    padding: EdgeInsets.only(bottom: 30.0),
                    children: [
                      Container(
                        child: Image.network(
                          "${documentData['image']}",
                          // fit: BoxFit.cover,
                          height: 320.0,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          // "${documentData['price']}" ?? 'Product Price',
                          'Bata shoes',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 12.0, bottom: 8.0, left: 24.0, right: 24.0),
                        child: Text(
                          "${documentData['name']}",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 24.0),
                        child: Text(
                          "${documentData['price']}",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 24.0),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${documentData['rating']}",
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          "${documentData['description']}",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          // "${documentData['desc']}" ?? 'Product Desc',
                          '"Best offer for today 20% off"',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await _addToSaved();
                                Scaffold.of(context)
                                    .showSnackBar(_snackBarAddToSaved);
                              },
                              child: Container(
                                width: 54.0,
                                height: 54.0,
                                decoration: BoxDecoration(
                                  color: Color(0xffdcdcdc),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                alignment: Alignment.center,
                                child: Icon(Icons.save_alt_rounded),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await _addToCart();
                                  Scaffold.of(context)
                                      .showSnackBar(_snackBarAddToCard);
                                },
                                child: Container(
                                  height: 54.0,
                                  margin: EdgeInsets.only(
                                    left: 16.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xfffb641b),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Stack(
                                    children: [
                                      Visibility(
                                        visible: widget._registerFormLoading
                                            ? false
                                            : true,
                                        child: Text(
                                          'Add to cart',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: widget._registerFormLoading,
                                        child: Center(
                                          child: SizedBox(
                                            height: 30.0,
                                            width: 30.0,
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Comments section
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.blueGrey,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              margin: EdgeInsets.all(8.0),
                              width: MediaQuery.of(context).size.width / 1.44,
                              child: CommentInput(
                                hintText: 'Add a public comment',
                                onChanged: (value) {
                                  _addComment = value;
                                },
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await _saveComment();
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  right: 8.0,
                                ),
                                width: 80.0,
                                height: 46.0,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Center(
                                  child: Text(
                                    'Add',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: ShowComment(
                          productId: widget.productId,
                        ),
                      )
                    ],
                  ),
                );
              }

              // Loading state
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
