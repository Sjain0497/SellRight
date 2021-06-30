import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sell_right/controller/user_controller.dart';
import 'package:sell_right/elements/BlockButtonWidget.dart';
import 'package:sell_right/generated/l10n.dart';
import 'package:sell_right/helpers/helper.dart';

import '../constant/app_properties.dart';
import 'package:flutter/material.dart';
import '../helpers/app_config.dart' as config;
import 'forgot_password_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends StateMVC<RegisterPage> {
  UserController _con;
  TextEditingController email =
      TextEditingController(text: 'example@email.com');

  TextEditingController password = TextEditingController(text: '12345678');

  TextEditingController cmfPassword = TextEditingController(text: '12345678');
  _RegisterPageState() : super(UserController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: _con.scaffoldKey,
      //  resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(

          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Container(
                height:config.App(context).appHeight(100),
              ),
              Positioned(
                top: 0,
                child: Container(
                  width: config.App(context).appWidth(100),
                  height: config.App(context).appHeight(100),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/register_back.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                    /* color: Theme.of(context).accentColor*/
                  ),
                ),
              ),
              Positioned(
                top: config.App(context).appHeight(29.5) - 160,
                child: Container(
                  width: config.App(context).appWidth(44),
                  height: config.App(context).appHeight(8.5),
                  child: Image.asset(
                    'assets/logo.png',
                    width: 20,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: config.App(context).appHeight(29.5) - 90,
                child: Container(
                  width: config.App(context).appWidth(84),
                  height: config.App(context).appHeight(29.5),
                  child: Text(
                    S.of(context).lets_start_with_register,
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        .merge(TextStyle(color: Theme.of(context).primaryColor)),
                  ),
                ),
              ),
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
                          keyboardType: TextInputType.text,
                          onSaved: (input) => _con.user.name = input,
                          validator: (input) => input.length < 3
                              ? S.of(context).should_be_more_than_3_letters
                              : null,
                          decoration: InputDecoration(
                            labelText: S.of(context).full_name,
                            labelStyle: TextStyle(color: Colors.black),
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.all(12),
                            hintText: S.of(context).john_doe,
                            hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.5)),
                            prefixIcon: Icon(Icons.person_outline,
                                color: Colors.black.withOpacity(0.7)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.5))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                          ),
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => _con.user.email = input,
                          validator: (input) => !input.contains('@')
                              ? S.of(context).should_be_a_valid_email
                              : null,
                          decoration: InputDecoration(
                            labelText: S.of(context).email,
                            labelStyle: TextStyle(color: Colors.black),
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.all(12),
                            hintText: 'johndoe@gmail.com',
                            hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.5)),
                            prefixIcon: Icon(Icons.alternate_email,
                                color: Colors.black.withOpacity(0.7)),
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
                        TextFormField(
                          obscureText: _con.hidePassword,
                          onSaved: (input) => _con.user.password = input,
                          validator: (input) => input.length < 6
                              ? S.of(context).should_be_more_than_6_letters
                              : null,
                          decoration: InputDecoration(
                            labelText: S.of(context).password,
                            labelStyle: TextStyle(color: Colors.black),
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.all(12),
                            hintText: '••••••••••••',
                            hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.5)),
                            prefixIcon: Icon(Icons.lock_outline,
                                color: Colors.black.withOpacity(0.7)),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _con.hidePassword = !_con.hidePassword;
                                });
                              },
                              color: Theme.of(context).focusColor,
                              icon: Icon(_con.hidePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
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

                        TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (input) => _con.user.phone = input,
                          validator: (input) => input.length < 3
                              ? S.of(context).should_be_more_than_3_characters
                              : null,
                          decoration: InputDecoration(
                            labelText: S.of(context).phone,
                            labelStyle: TextStyle(color: Colors.black),
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.all(12),
                            hintText: '+911234567890',
                            hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.5)),
                            prefixIcon: Icon(Icons.phone,
                                color: Colors.black.withOpacity(0.7)),
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
                            S.of(context).register,
                            style: TextStyle(color: Theme.of(context).primaryColor),
                          ),
                          color: buttonColor,
                          onPressed: () {
                            _con.register();

                          },
                        ),
                        SizedBox(height: 25),

                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 10,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/Login');
                  },
                  textColor: Theme.of(context).hintColor,
                  child: Text(S.of(context).i_have_account_back_to_login),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
