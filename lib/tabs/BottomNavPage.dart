
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uwokart/screens/HomePage.dart';
import 'package:uwokart/screens/add_product.dart';
import 'package:uwokart/screens/display_products.dart';
import 'package:uwokart/tabs/MoviesPage.dart';
import 'package:uwokart/tabs/SavedPage.dart';
import 'package:uwokart/tabs/bottom_tabs.dart';

class BottomNavPage extends StatefulWidget {
  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  late PageController _tabsPagesController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPagesController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPagesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: PageView(
            controller: _tabsPagesController,
            onPageChanged: (num) {
              setState(() {
                _selectedTab = num;
              });
            },
            children: [
              HomePage(),
              DisplayProducts(),
              AddProduct(),
              SavedPage(),
              MoviesPage(),
            ],
          ),
        ),
        BottomTabs(
          selectedTab: _selectedTab,
          tabPressed: (num) {
            _tabsPagesController.animateToPage(
              num,
              duration: Duration(microseconds: 300),
              curve: Curves.easeInCubic,
            );
          },
        )
      ],
    ));
  }
}

// onPressed: () {
//   FirebaseAuth.instance.signOut();
// },
