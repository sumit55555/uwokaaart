
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uwokart/tabs/BottomNavPage.dart';

class AppbarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavPage(),
            ),
          );
        },
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 6.0),
              height: 30.0,
              width: 30.0,
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Text(
                  'Fusion',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xffffffff),
                  ),
                ),
                Text(
                  'Fashion',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xffffffff),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
