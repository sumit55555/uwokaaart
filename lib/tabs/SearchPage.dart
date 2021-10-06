
import 'package:flutter/material.dart';
import 'package:uwokart/costants.dart';
import 'package:uwokart/widgets/custom_input.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Center(
              child: Container(
                child: Text(
                  "Search Results",
                  style: Constants.regularDarkText,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 45.0,
              ),
              child: CustomInput(
                hintText: "Search here...",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
