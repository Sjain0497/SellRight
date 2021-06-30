import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AboutListItem extends StatelessWidget {
  final String title;

  AboutListItem({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15.0,
      width: 15.0,
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,

      ),
    );
  }
}
