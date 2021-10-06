import 'package:flutter/material.dart' hide Router;

class LoginText extends StatelessWidget {
  final String text;
  final String subtext;
  LoginText({required this.text, required this.subtext});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 6.0),
            child: Text(
              text,
              style: TextStyle(fontSize: 16.0, color: Color(0xffE81667)),
            ),
          ),
          Container(
            child: Text(
              subtext,
              style: TextStyle(fontSize: 16.0, color: Color(0xff0073ff)),
            ),
          ),
        ],
      ),
    );
  }
}
