
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uwokart/screens/tabs/deals_prod.dart';

import '../grid_img.dart';

class DiscountsProd extends StatelessWidget {
  final String text;
  DiscountsProd({required this.text});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.teal,
              Colors.deepPurple,
              Colors.purple,
            ],
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 16.0,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$text',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(0xff0073ff),
                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 1.0,
                        blurRadius: 30.0,
                      )
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              // New Deals
                              DealsProd(
                            text: 'New deals for you', img: '',
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'View All >',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 12.0),
              child: GridImg(),
            ),
          ],
        ),
      ),
    );

  }
}
