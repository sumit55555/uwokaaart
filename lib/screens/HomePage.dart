import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uwokart/screens/tabs/discounts_prod.dart';
import 'package:uwokart/screens/tabs/sponsored_prod.dart';
import 'package:uwokart/screens/tabs/three_prod.dart';
import 'package:uwokart/services/appbar_title.dart';
import 'package:uwokart/services/cart_nav.dart';
import 'package:uwokart/services/profile_icon.dart';
import 'package:uwokart/tabs/SearchPage.dart';
import 'package:uwokart/widgets/slider.dart';
import 'package:uwokart/widgets/top_deals.dart';
import 'package:uwokart/widgets/top_slider.dart';

class HomePage extends StatelessWidget {
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
              child: CartNav()),
          ProfileIcon(),
        ],
      ),
      body: ListView(
        children: [
          TopSlider(),
          ImageSlider(),
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TopDeals(title: 'T-shirts', imgUrl: 'assets/images/w1.png'),
                TopDeals(title: 'T-shirts', imgUrl: 'assets/images/w3.jpg'),
                TopDeals(title: 'T-shirts', imgUrl: 'assets/images/w2.jpg'),
              ],
            ),
          ),
          DiscountsProd(
            text: 'Discounts for you',
          ),
          Sponsored(
            img: 'assets/images/p5.jpg',
          ),

          // Sponsored(
          //   img: 'assets/images/p4.jpg',
          // ),
          // Sponsored(
          //   img: 'assets/images/banner-3.png',
          // ),
          // ScrollProd(),
          // New Products
          ThreeProd(
            text: 'New deals for you',
          ),
        ],
      ),
    );
  }
}
