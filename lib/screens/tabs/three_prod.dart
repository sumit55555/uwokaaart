
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uwokart/widgets/new_products.dart';

class ThreeProd extends StatelessWidget {
  final String text;
  ThreeProd({required this.text});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 10.0,
            left: 10.0,
            right: 10.0,
            bottom: 6.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$text',
                style: TextStyle(
                  color: Colors.black,
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
                child: Text(
                  'View All >',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3,
              margin: EdgeInsets.only(top: 6.0, bottom: 16.0),
              child: NewProducts(
                image: 'assets/images/p1.jpeg',
                name: 'Striped Men Round Neck Green T-Shirt',
                price: '407',
                rating: '1092 off', productId: '',
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              margin: EdgeInsets.only(top: 6.0, bottom: 16.0),
              child: NewProducts(
                image: 'assets/images/p2.jpeg',
                name: 'Color Block Men Hooded Neck Green T-Shirt',
                price: '299',
                rating: '1092 off', productId: '',
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              margin: EdgeInsets.only(top: 6.0, bottom: 16.0),
              child: NewProducts(
                image: 'assets/images/p3.jpeg',
                name: 'Men Slim Fit Color Block Spread Collar Casual Shirt',
                price: '626',
                rating: '1092 off', productId: '',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
