import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopDeals extends StatelessWidget {
  final String title;
  final String imgUrl;
  TopDeals({required this.imgUrl, required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(6.0),
          bottomRight: Radius.circular(6.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2.0,
            blurRadius: 30.0,
          )
        ],
      ),
      width: 110.0,
      height: 140.0,
      child: Column(
        children: [
          Container(
            child: Center(
              child: Image(
                image: AssetImage("${imgUrl}"),
                fit: BoxFit.cover,
                height: 100.0,
              ),
            ),
          ),
          Container(
            color: Color(0xff02be6e),
            width: MediaQuery.of(context).size.width,
            // margin: EdgeInsets.only(top: 10.0),
            padding: EdgeInsets.symmetric(vertical: 6.0),
            child: Center(
              child: Text(
                '${title}',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
