import 'package:flutter/material.dart';
import 'package:sell_right/elements/ProfileAvatarWidget.dart';
import 'package:sell_right/generated/l10n.dart';

import 'package:sell_right/models/route_argument.dart';
import 'package:sell_right/repository/user_repository.dart';
import '../helpers/app_config.dart' as config;
import '../elements/ProfileSettingsDialog.dart';
class SettingScreen extends StatefulWidget {
  final RouteArgument routeArgument;
    SettingScreen({Key key, this.routeArgument}) : super(key: key);
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String txt='';

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return  Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.transparent,
       iconTheme: IconThemeData(
         color: Colors.white, //change your color here
       ),
       elevation: 0.0,
       title: Text(

         S.of(context).settings,
         textAlign: TextAlign.center,
         style: TextStyle(color: Colors.white,),
       ),
     ),
       extendBodyBehindAppBar: true,
     body:Container(
     height: config.App(context).appHeight(100),
     decoration: BoxDecoration(
     image: DecorationImage(
     image: AssetImage('assets/my_Catalouge_Back.jpg'), fit: BoxFit.cover)),
    child : ListView(
       children: <Widget>[
         ListTile(
           leading: Icon(
             Icons.person,
             color: Colors.white,
           ),
           title: Text(
             currentUser.value.name,
             textScaleFactor: 1.5,
             style: TextStyle(color: Colors.white),
           ),
           subtitle: Text(
             '${currentUser.value.phone}',
             style: TextStyle(color: Colors.white),
           ),
           trailing: ButtonTheme(
             padding: EdgeInsets.all(0),
             minWidth: 50.0,
             height: 25.0,
             child: ProfileSettingsDialog(
               user: currentUser.value,
               onChanged: () {
               //  _con.update(currentUser.value);
//                                  setState(() {});
               },
             ),
           ),
           selected: true,
           onTap: () {},
         ),

         Divider(color: Colors.grey,),
         ListTile(
           leading: Icon(Icons.next_plan_outlined,color: Colors.white,),
           title: Text('Plans & Billing',textScaleFactor: 1.5, style: TextStyle(color: Colors.white),),
         //  trailing: Icon(Icons.done),
           subtitle: Text('Manage Your Current Plan and Your Information', style: TextStyle(color: Colors.white),),
           selected: true,
           onTap: () {
             setState(() {
               Navigator.of(context).pushNamed('/PlanDetailScreen');
             });
           },
         ),
         Divider(color: Colors.grey,),
         ListTile(
           leading: Icon(Icons.account_box_outlined,color: Colors.white,),
           title: Text( S.of(context).about,textScaleFactor: 1.5, style: TextStyle(color: Colors.white),),
          // trailing: Icon(Icons.done),
           subtitle: Text('More information about Websquareit', style: TextStyle(color: Colors.white),),
           selected: true,
           onTap: () {
             setState(() {
               Navigator.of(context).pushNamed('/AboutScreen');
             });
           },
         ),
         Divider(color: Colors.grey,),
       ],
     ),
   ));
  }

}