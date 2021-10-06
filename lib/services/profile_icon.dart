
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uwokart/tabs/ProfilePage.dart';

class ProfileIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Center(
          child: Text(
            'Profile',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
