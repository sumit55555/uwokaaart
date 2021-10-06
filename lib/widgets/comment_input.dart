import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentInput extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  CommentInput({
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfff2f2f2),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 12.0,
          ),
        ),
        // style: Constants.regularDarkText,
      ),
    );
  }
}
