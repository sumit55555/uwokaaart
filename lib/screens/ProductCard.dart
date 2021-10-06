
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uwokart/screens/ShowProduct.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  final String image;
  final String name;
  final String price;
  final String rating;

  ProductCard({required this.image, required this.productId, required this.name, required this.price, required this.rating});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowProduct(
              productId: productId,
            ),
          ),
        );
      },
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                height: 120.0,
                child: Image.network(
                  "$image",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                child: Text(
                  '$name',
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.w800,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$rating',
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
              SizedBox(height: 8),
              Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  '\$$price',
                  style: TextStyle(fontSize: 32, fontFamily: 'avenir'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
