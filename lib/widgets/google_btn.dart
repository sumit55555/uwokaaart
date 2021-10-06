import 'package:flutter/material.dart' hide Router;

class GoogleBtn extends StatelessWidget {
  final String imageUrl;
  final String text;
  GoogleBtn({required this.imageUrl, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.0,
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffF14336), width: 0.6),
          borderRadius: BorderRadius.circular(8.0)),
      child: Row(
        children: [
          Image(
            image: AssetImage("${imageUrl}"),
            width: 24.0,
            height: 24.0,
          ),
          Container(margin: EdgeInsets.only(left: 10.0), child: Text(text)),
        ],
      ),
    );
  }
}
