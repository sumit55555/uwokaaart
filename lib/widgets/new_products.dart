
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewProducts extends StatelessWidget {
  final String productId;
  final String image;
  final String name;
  final String price;
  final String rating;

  NewProducts({required this.image, required this.productId, required this.name, required this.price, required this.rating});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 4.0,
            ),
            height: 120.0,
            child: Image(
              image: AssetImage("$image"),
              fit: BoxFit.cover,
            ),
          ),

          // Name area
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '$name',
              maxLines: 1,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'avenir',
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 6),
          // Price area
          Container(
            padding: EdgeInsets.only(
              bottom: 2.0,
              left: 16.0,
              right: 16.0,
            ),
            alignment: Alignment.topLeft,
            child: Text(
              '₹$price',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'avenir',
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          // Discount offer area
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.topLeft,
            child: Container(
              child: Text(
                '₹$rating',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontFamily: 'avenir',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
