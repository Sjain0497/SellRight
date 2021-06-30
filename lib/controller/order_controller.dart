import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../generated/l10n.dart';
import '../models/Order.dart';
import '../repository/order_repository.dart';

class OrderController extends ControllerMVC {
  List<Order> orders = <Order>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  OrderController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForOrders();
  }

  void listenForOrders({String message}) async {
    final Stream<Order> stream = await getOrders();
    stream.listen((Order _order) {
      setState(() {
        orders.add(_order);
      });
    }, onError: (e) {
      print(e);
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S.of(context).verify_your_internet_connection),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }
  void dochangeOrderStatus(Order order, String dropdownValue){
    print("DropDownValue...$dropdownValue");
    cancelOrder(order,dropdownValue).then((value) {
      setState(() {
      //  order.active = false;
      });
    }).catchError((e) {
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(e),
      ));
    }).whenComplete(() {
      //refreshOrders();
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S.of(context).orderThisorderidHasBeenCanceled(order.product)),
      ));
    });
  }



  Future<void> refreshOrders() async {
    orders.clear();
    listenForOrders(message: S.of(context).order_refreshed_successfuly);
  }
}
