import 'package:sell_right/screens/confirm_otp_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../constant/app_properties.dart';
import '../controller/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:sell_right/screens/intro_page.dart';
import '../repository/user_repository.dart' as userRepo;
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends StateMVC<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> opacity;
  AnimationController controllerAnimation;
  SplashScreenController _con;
  _SplashScreenState() : super(SplashScreenController()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();
    controllerAnimation = AnimationController(
        duration: Duration(milliseconds: 2500), vsync: this);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controllerAnimation)
      ..addListener(() {
        setState(() {});
      });
    controllerAnimation.forward().then((_) {
      navigationPage();
    });

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void navigationPage() {
    if(userRepo.currentUser.value.auth==true){
      Navigator.of(_con.scaffoldKey.currentContext).pushReplacementNamed('/Home');
    }else{
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => IntroPage()));
    }

  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/splash_screen.png'), fit: BoxFit.cover)),
        child:Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
               SizedBox(height: 20),
              Image.asset(
                'assets/logo.png',
                width: 150,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              // SizedBox(height:20),
             // Center(
             //   child:  CircularProgressIndicator(
             //     valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
             //
             //   ),
             // ),
               SizedBox(height: 20),
              RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: 'Powered by '),
                      TextSpan(
                          text: 'websquareit',
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ]),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
