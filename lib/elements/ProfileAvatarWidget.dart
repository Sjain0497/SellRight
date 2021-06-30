import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final User user;
  ProfileAvatarWidget({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      // decoration: BoxDecoration(
      //   color: Theme.of(context).accentColor,
      //   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      // ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.black,
            ),
            title: Text(
              user.name,
              textScaleFactor: 1.5,
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text(
              '${user.phone}',
              style: TextStyle(color: Colors.black),
            ),
            selected: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
