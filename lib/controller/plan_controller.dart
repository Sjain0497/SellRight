import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../repository/plan_repository.dart' as repo;
import '../repository/user_repository.dart' as userRepo;
import 'package:sell_right/generated/l10n.dart';
import 'package:sell_right/helpers/helper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class PlanController extends ControllerMVC {
  OverlayEntry loader;
  GlobalKey<ScaffoldState> scaffoldKey;
//add Products...
  PlanController() {
    loader = Helper.overlayLoader(context);
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
  void createPlanPayment(String amount, String planType) {
    Overlay.of(context).insert(loader);
    repo.createPlanDetaiil(amount, planType).then((value) {
      if (value != null) {
        //   Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments:1);
        Fluttertoast.showToast(msg: 'success');
        Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Home');
      } else {
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(S.of(context).wrong_email_or_password),
        ));
      }
    })
      ..catchError((e) {
        loader?.remove();
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(S.of(context).this_email_account_exists),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
  }
}
