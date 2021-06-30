import 'package:flutter/material.dart';
import 'package:sell_right/screens/HomeScreen.dart';
import 'package:sell_right/screens/aboutus.dart';
import 'package:sell_right/screens/add_edit_product_screen.dart';
import 'package:sell_right/screens/add_edit_catalouge_screen.dart';
import 'package:sell_right/screens/confirm_otp_page.dart';
import 'package:sell_right/screens/intro_page.dart';
import 'package:sell_right/screens/planDetails.dart';
import 'package:sell_right/screens/register_page.dart';
import 'package:sell_right/screens/splash_page.dart';
import 'package:sell_right/screens/product_screen.dart';
import 'screens/UploadImages.dart';
import 'screens/orders.dart';
import 'models/route_argument.dart';
import 'screens/ImageUpload.dart';
import 'screens/login_page.dart';
import 'screens/setting_screen.dart';
import 'screens/homeWithPlanData.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {

      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/Intro':
        return MaterialPageRoute(builder: (_)=>IntroPage());
      case '/Register':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case '/Login':
        return MaterialPageRoute(builder: (_) => WelcomeBackPage());
      case '/ConfirmOtp':
        return MaterialPageRoute(builder: (_)=>ConfirmOtpPage());
      case '/Home':
        return MaterialPageRoute(builder: (_)=>HomeScreen());
      case '/SingleImage':
        return MaterialPageRoute(builder: (_)=>SingleImageUpload());
      case '/AddProductEditScreen':
       // return MaterialPageRoute(builder: (_)=>UploadImageDemo());
        final productId = settings.arguments;
        return MaterialPageRoute(builder: (_)=>AddEditProductScreen( productId: productId));
      case '/AddCatalougeEditScreen':
        final catId = settings.arguments;
        return MaterialPageRoute(builder: (_)=>AddEditCatalougeScreen( catalougeId:catId));
      case '/ProductScreen':
        return MaterialPageRoute(builder: (_)=>ProductScreen(routeArgument: args  as RouteArgument));
      case '/PlanDetailScreen':
        return MaterialPageRoute(builder: (_)=>PlanDetailScreen(routeArgument: args  as RouteArgument));
      case '/HomeWithPlanScreen':
        return MaterialPageRoute(builder: (_)=>HomeWithPlanScreen());
      case '/OrdersWidget':
        return MaterialPageRoute(builder: (_)=>OrdersWidget());
      case '/AboutScreen':
        return MaterialPageRoute(builder: (_)=>AboutUsWidget());
      case '/SettingScreen':
        return MaterialPageRoute(builder: (_)=>SettingScreen(routeArgument: args  as RouteArgument));
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(builder: (_) => Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
