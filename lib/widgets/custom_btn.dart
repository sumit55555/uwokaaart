
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;
  final bool isLoading;
  CustomBtn({required this.text, required this.onPressed, required this.outlineBtn, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    bool _outlineBtn = outlineBtn;
    bool _isLoading = isLoading;

    return GestureDetector(
      onTap: onPressed(),
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => HomePage(),
      //     ),
      //   );
      // },
      child: Container(
        height: 55.0,
        decoration: BoxDecoration(
            color: _outlineBtn ? Colors.transparent : Color(0xffE81667),
            // border: Border.all(color: Color(0xffE81667), width: 2.0),
            borderRadius: BorderRadius.circular(12.0)),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      color: _outlineBtn ? Colors.blue : Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
