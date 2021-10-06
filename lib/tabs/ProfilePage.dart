
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uwokart/services/appbar_title.dart';
import 'package:uwokart/services/cart_nav.dart';
import 'package:uwokart/services/profile_icon.dart';
import 'package:uwokart/tabs/SearchPage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("Users");

  final User _user = FirebaseAuth.instance.currentUser;
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
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Icon(
              Icons.account_box_rounded,
              size: 300,
            ),
          ),
          Container(
            padding: EdgeInsets.all(24.0),
            margin: EdgeInsets.symmetric(horizontal: 25.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 1.0,
                  blurRadius: 30.0,
                )
              ],
            ),
            child: Center(
              child: Text(
                '${_user.email}',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(top: 40.0),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(8.0),
                color: Theme.of(context).accentColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1.0,
                    blurRadius: 30.0,
                  )
                ],
              ),
              child: Center(
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
      // body: Container(
      //   child: Center(
      //     child: GestureDetector(
      //       onTap: () async {
      //         await FirebaseAuth.instance.signOut();
      //         Navigator.pop(context);
      //       },
      //       child: Container(
      //         child: Text('Logout'),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
