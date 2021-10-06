
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uwokart/tabs/BottomNavPage.dart';

import '../HomeProducts.dart';

class DealsProd extends StatelessWidget {
  final String text;
  final String img;
  DealsProd({required this.text, required this.img});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavPage(),
              ),
            );
          },
          child: Text(
            'V-mart',
            style: TextStyle(
              fontSize: 26.0,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xff0cacc3),
              Color(0xff5e65c2),
              Color(0xffa32dc6),
            ],
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 16.0,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 12.0),
              child: HomeProducts(),
            ),
          ],
        ),
      ),
    );
  }
}
