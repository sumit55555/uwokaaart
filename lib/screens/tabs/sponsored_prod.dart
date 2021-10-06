import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Sponsored extends StatelessWidget {
  final String img;
  Sponsored({required this.img});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'Featured Brand',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage('$img'),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
