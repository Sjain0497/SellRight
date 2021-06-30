import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sell_right/elements/EmptyCartWidget.dart';
import '../elements/OrderItemWidget.dart';
import '../generated/l10n.dart';
import '../controller/order_controller.dart';
import '../helpers/app_config.dart' as config;
import '../repository/user_repository.dart';

class OrdersWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  OrdersWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends StateMVC<OrdersWidget> {
  OrderController _con;

  _OrdersWidgetState() : super(OrderController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    print("OrderLength...${_con.orders.length}");
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text(
          S.of(context).my_orders,
          style: Theme.of(context)
              .textTheme
              .headline4
              .merge(TextStyle(letterSpacing: 1.3,color: Colors.white)),
        ),

      ),
      extendBodyBehindAppBar: true,
      body:Stack(
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
                    'assets/my_Catalouge_Back.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
                /* color: Theme.of(context).accentColor*/
              ),
              //decoration: BoxDecoration(color: Theme.of(context).accentColor),
            ),
          ),
          _con.orders.isEmpty
              ? EmptyCatlougeWidget(text: S.of(context).dont_have_any_order)
              : RefreshIndicator(
            onRefresh: _con.refreshOrders,
            child: Container(

              width: config.App(context).appWidth(100),
              height: config.App(context).appHeight(100),
              child: SingleChildScrollView(

                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[

                    SizedBox(height: 20),
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: _con.orders.length,
                      itemBuilder: (context, index) {
                        var _order = _con.orders.elementAt(index);
                        return OrderItemWidget(
                          expanded: index == 0 ? true : false,
                          order: _order,
                          // onCanceled: (e) {
                          //   _con.dochangeOrderStatus(_order,dropdownValue);
                          // },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 20);
                      },
                    ),
                  ],
                ),
              ),
            )
          ),

        ],
      ),
    );
  }
}
