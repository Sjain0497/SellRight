import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sell_right/controller/user_controller.dart';
import 'package:sell_right/generated/l10n.dart';
import 'package:sell_right/helpers/helper.dart';

import '../screens/register_page.dart';
import '../elements/BlockButtonWidget.dart';
import '../constant/app_properties.dart';
import 'package:flutter/material.dart';
import '../helpers/app_config.dart' as config;

class WelcomeBackPage extends StatefulWidget {
  @override
  _WelcomeBackPageState createState() => _WelcomeBackPageState();
}

class _WelcomeBackPageState extends StateMVC<WelcomeBackPage> {
  TextEditingController email =
      TextEditingController(text: 'example@email.com');
  UserController _con;
  TextEditingController password = TextEditingController(text: '12345678');
  _WelcomeBackPageState() : super(UserController()) {
    _con = controller;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: Helper.of(context).onWillPop,
    child: Scaffold(
      key: _con.scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
              width: config.App(context).appWidth(100),
              height: config.App(context).appHeight(100),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/Login_back.png',
                  ),
                  fit: BoxFit.cover,
                ),
                /* color: Theme.of(context).accentColor*/
              ),
              //decoration: BoxDecoration(color: Theme.of(context).accentColor),
            ),
          ),
          Positioned(
            top: config.App(context).appHeight(29.5) - 140,
            child: Container(
              width: config.App(context).appWidth(44),
              height: config.App(context).appHeight(8.5),
              child: Image.asset(
                'assets/white_logo.png',
                width: 20,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.only(left: 28.0),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: <Widget>[
          //       Spacer(flex: 3),
          //       welcomeBack,
          //       Spacer(),
          //       subTitle,
          //       Spacer(flex: 2),
          //       loginForm,
          //       Spacer(flex: 2),
          //       forgotPassword
          //     ],
          //   ),
          // )
          Positioned(
            top: config.App(context).appHeight(37) - 50,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 50,
                      color: Theme.of(context).hintColor.withOpacity(0.2),
                    )
                  ]),
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              padding:
                  EdgeInsets.only(top: 50, right: 27, left: 27, bottom: 20),
              width: config.App(context).appWidth(88),
//              height: config.App(context).appHeight(55),
              child: Form(
                key: _con.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (input) => _con.user.phone = input,
                      validator: (input) => input.length < 3
                          ? S.of(context).should_be_more_than_3_characters
                          : null,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: S.of(context).phone,
                        labelStyle: TextStyle(color: Colors.black),
                        contentPadding: EdgeInsets.all(12),
                        hintText: '+911234567890',
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.7)),
                        prefixIcon: Icon(Icons.phone,
                            color: Colors.black),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black.withOpacity(1))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(1))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.8))),
                      ),
                      style: TextStyle(fontSize: 15.0, color: Colors.black),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      onSaved: (input) => _con.user.password = input,
                      validator: (input) => input.length < 3
                          ? S.of(context).should_be_more_than_3_characters
                          : null,
                      obscureText: _con.hidePassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: S.of(context).password,
                        labelStyle: TextStyle(color: Colors.black),
                        contentPadding: EdgeInsets.all(12),
                        hintText: '••••••••••••',
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.7)),
                        prefixIcon: Icon(Icons.lock_outline,
                           color: Colors.black),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _con.hidePassword = !_con.hidePassword;
                            });
                          },
                          color: Theme.of(context).focusColor,
                          icon: Icon(_con.hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,color: Colors.black,),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.8))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(1))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.8))),
                      ),
                      style: TextStyle(fontSize: 15.0, color: Colors.black),
                    ),
                    SizedBox(height: 30),

                    BlockButtonWidget(
                      text: Text(
                        S.of(context).login,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      color: buttonColor,
                      onPressed: () {
                        _con.login();
                      },
                    ),
                    SizedBox(height: 15),

//                      SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: Column(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed('/ForgetPassword');
                  },
                  textColor: Theme.of(context).hintColor,
                  child: Text(S.of(context).i_forgot_password),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/Register');
                  },
                  textColor: Theme.of(context).hintColor,
                  child: Text(S.of(context).i_dont_have_an_account),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
