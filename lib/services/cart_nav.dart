
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uwokart/tabs/CartPage.dart';

class CartNav extends StatefulWidget {
  @override
  _CartNavState createState() => _CartNavState();
}

class _CartNavState extends State<CartNav> {
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("Users");

  final User _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartPage()));
            },
            child: Container(
                child: Row(
              children: [
                Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 22,
                ),
                StreamBuilder(
                  stream:
                      _usersRef.doc(_user.uid).collection("Cart").snapshots(),
                  builder: (context, snapshot) {
                    int _totalItems = 0;

                    //just add this line
                    if (snapshot.data == null)
                      return CircularProgressIndicator();

                    if (snapshot.connectionState == ConnectionState.active) {
                      List _documents = snapshot.data!.docs;
                      _totalItems = _documents.length;
                    }
                    return Container(
                      width: 16.0,
                      height: 16.0,
                      margin: EdgeInsets.only(bottom: 20.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xffE81667),
                          borderRadius: BorderRadius.circular(40)),
                      child: Text(
                        '$_totalItems',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
