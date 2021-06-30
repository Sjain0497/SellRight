import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sell_right/models/route_argument.dart';
import 'package:sell_right/repository/user_repository.dart';
import '../constant/app_properties.dart';
import '../helpers/app_config.dart' as config;
import '../generated/l10n.dart';
import '../controller/plan_controller.dart';
class PlanDetailScreen extends StatefulWidget {
  final RouteArgument routeArgument;
  PlanDetailScreen({Key key, this.routeArgument}) : super(key: key);
  @override
  _PlanDetailScreenState createState() => _PlanDetailScreenState();
}

class _PlanDetailScreenState extends StateMVC<PlanDetailScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Razorpay _razorpay;
  int _selectedTab = 0;
  PlanController _con;
  _PlanDetailScreenState() : super(PlanController()) {
    _con = controller;

  }
  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedTab = _tabController.index;
        });
      }
    });
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
    Navigator.of(_con.scaffoldKey.currentContext).pushReplacementNamed('/Home');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIosWeb: 4);
    Navigator.of(_con.scaffoldKey.currentContext).pushReplacementNamed('/PlanDetailScreen');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }
  @override
  void dispose() {

    super.dispose();
    _razorpay.clear();
  }
  void openCheckout(String amount,String validity) async {

    int getAmount=int.parse(amount);
    print("Amount...$getAmount");
    var options = {
      'key': 'rzp_live_jhJHx3BUcXJbjy',
      'amount': getAmount,
      'name': 'Sell Right',
      'description': 'Payment',
      //'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    _con.createPlanPayment(amount.toString(),validity);
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text(
            S.of(context).Plan_Detail,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: Container(
          height: config.App(context).appHeight(100),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/my_Catalouge_Back.jpg'),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 30),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 1,
                child: _tabSection(context),
              )


            ],
          ),
        )) ;
  }

  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(height: 100),
          Container(
            child: Text(
              'Pricing',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  wordSpacing: 3.0,
                  letterSpacing: 2.0,
                  fontStyle: FontStyle.italic),
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: new EdgeInsets.only(left: 20.0,right: 20.0),
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            decoration: BoxDecoration(
              color: Colors.white,
            //  border: Border.all(color: darkGrey, width: 1.0),
              // borderRadius: BorderRadius.all(
              //     Radius.circular(5.0) //         <--- border radius here
              // ),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).focusColor.withOpacity(0.5),
                    blurRadius: 5,
                    offset: Offset(0, 2)),
              ],),
            child: TabBar(
              unselectedLabelColor: blackColor,
              labelColor: whiteColor,
              indicator: BoxDecoration(
               //   borderRadius: BorderRadius.circular(50),
                  color: blueColor),
              controller: _tabController,
              labelPadding: const EdgeInsets.all(0.0),
              tabs: [
                 _getTab(0,
                   new Column(
                    children: <Widget>[
                      new Text("1 Month"),
                      new SizedBox(
                        width: 5.0,
                      ),
                      new Text("\u{20B9} 500.00"),
                    ],
                  ),
                ),
                _getTab(1,
                   new Column(
                    children: <Widget>[
                      new Text("6 Month"),
                      new SizedBox(
                        width: 5.0,
                      ),
                      new Text("\u{20B9} 2000.00"),
                    ],
                  ),
                ),
                _getTab(2,
                 new Column(
                    children: <Widget>[
                      new Text("12 Month"),
                      new SizedBox(
                        width: 5.0,
                      ),
                      new Text("\u{20B9} 4000.00"),
                    ],
                  ),
                ),

                // _getTab(0, new Row(
                //   children: <Widget>[
                //     new Icon(Icons.airplanemode_active),
                //     new SizedBox(
                //       width: 5.0,
                //     ),
                //     new Text("First"),
                //   ],
                // ),),
                // _getTab(1, Icon(Icons.directions_transit)),
                // _getTab(2, Icon(Icons.directions_bike)),
              ],
            ),
          ),
          Container(
            margin: new EdgeInsets.only(left: 20.0,right: 20.0),
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(1.0),
              //border: Border.all(color: darkGrey, width: 1.0),
              // borderRadius: BorderRadius.all(
              //     Radius.circular(5.0) //         <--- border radius here
              // ),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).focusColor.withOpacity(0.5),
                    blurRadius: 5,
                    offset: Offset(0, 2)),
              ],),
            height: MediaQuery.of(context).size.height/2 ,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors
                          .transparent, //remove color to make it transpatent
                      border: Border.all(
                          style: BorderStyle.solid, color: Colors.transparent)),
                  child:   ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                       margin: EdgeInsets.only(bottom: 0,top: 5.0),
                        padding: new EdgeInsets.all(1.0),
                        width: MediaQuery.of(context).size.width,
                        height: 20,
                        child:  Center(
                          child:  Text(
                              "\u{20B9} 500.00",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style:
                            TextStyle(color: blueColor, fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ),
                      Container(
                          margin: EdgeInsets.only(bottom: 0,top: 5.0),

                          width: MediaQuery.of(context).size.width,
                          height: 20,
                          child:  Center(
                            child:  Text(
                                "1 month validity",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,

                              style:
                              TextStyle(color: blueColor, fontSize: 15,
                                  fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,letterSpacing: 1.0),
                            ),
                          )
                      ),

                      Container(
                        margin: EdgeInsets.only(bottom: 0,top: 5.0,left: 30.0,right: 30.0),
                        padding: new EdgeInsets.all(5.0),
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child:  FlatButton(
                          onPressed: (){
                            openCheckout("500","1 Month");
                          },
                         // padding: EdgeInsets.all(25.0),
                          color: buttonColor,
                          shape: StadiumBorder(),
                          child:  Text(
                            S.of(context).buyNow,
                            style: TextStyle(color: Theme.of(context).primaryColor,
                            fontWeight:FontWeight.bold ,
                            fontSize: 20.0),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(bottom: 0,top: 5.0),

                          width: MediaQuery.of(context).size.width,
                          height: 20,
                          child:  Center(
                            child:  Text(
                              "Compare with other plans",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style:
                              TextStyle(color: blueColor, fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                      ),
                      new SizedBox(
                        height: 20.0,
                      ),
                      ListTile(
                        dense: true,
                        leading: Icon(Icons.border_outer_outlined,size: 20.0,color: blackColor,),
                        title: Text('10 catalouges',textScaleFactor: 1.5,style: TextStyle(color: blackColor, fontSize: 10,
                           ),),
                      //  trailing: Icon(Icons.done),
                      ),
                      ListTile(
                        dense: true,
                        leading: Icon(Icons.enhance_photo_translate_sharp,size: 20.0,color: blackColor,),
                        title: Text('200 products',textScaleFactor: 1.5,style: TextStyle(color: blackColor, fontSize: 10,
                         ),),
                        //  trailing: Icon(Icons.done),
                      ),
                      ListTile(
                        dense: true,
                        leading: Icon(Icons.reorder,size: 20.0,color: blackColor,),
                        title: Text('Unlimited orders',textScaleFactor: 1.5,style: TextStyle(color: blackColor, fontSize: 10,
                          ),),
                        //  trailing: Icon(Icons.done),
                      ),
                      ListTile(
                        dense: true,
                        leading: Icon(Icons.remove_red_eye,size: 20.0,color: blackColor,),
                        title: Text('Unlimited visitors',textScaleFactor: 1.5,style: TextStyle(color: blackColor, fontSize: 10,
                       ),),
                        //  trailing: Icon(Icons.done),
                      ),

                    ],
                  )
                ),

                Container(
                    decoration: BoxDecoration(
                        color: Colors
                            .transparent, //remove color to make it transpatent
                        border: Border.all(
                            style: BorderStyle.solid, color: Colors.transparent)),
                    child:   ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 0,top: 5.0),
                            padding: new EdgeInsets.all(1.0),
                            width: MediaQuery.of(context).size.width,
                            height: 20,
                            child:  Center(
                              child:  Text(
                                "\u{20B9} 2000.00",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style:
                                TextStyle(color: blueColor, fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 0,top: 5.0),

                            width: MediaQuery.of(context).size.width,
                            height: 20,
                            child:  Center(
                              child:  Text(
                                "6 month validity",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,

                                style:
                                TextStyle(color: blueColor, fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,letterSpacing: 1.0),
                              ),
                            )
                        ),

                        Container(
                          margin: EdgeInsets.only(bottom: 0,top: 5.0,left: 30.0,right: 30.0),
                          padding: new EdgeInsets.all(5.0),
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child:  FlatButton(
                            onPressed: (){
                              openCheckout("2000","6 Month");
                            },
                            // padding: EdgeInsets.all(25.0),
                            color: buttonColor,
                            shape: StadiumBorder(),
                            child:  Text(
                              S.of(context).buyNow,
                              style: TextStyle(color: Theme.of(context).primaryColor,
                                  fontWeight:FontWeight.bold ,
                                  fontSize: 20.0),
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 0,top: 5.0),

                            width: MediaQuery.of(context).size.width,
                            height: 20,
                            child:  Center(
                              child:  Text(
                                "Compare with other plans",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style:
                                TextStyle(color: blueColor, fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                        ),
                        new SizedBox(
                          height: 20.0,
                        ),
                        ListTile(
                          dense: true,
                          leading: Icon(Icons.border_outer_outlined,size: 20.0,color: blackColor,),
                          title: Text('60 catalouges',textScaleFactor: 1.5,style: TextStyle(color: blackColor, fontSize: 10,
                            ),),
                          //  trailing: Icon(Icons.done),
                        ),
                        ListTile(
                          dense: true,
                          leading: Icon(Icons.enhance_photo_translate_sharp,size: 20.0,color: blackColor,),
                          title: Text('1000 products',textScaleFactor: 1.5,style: TextStyle(color: blackColor, fontSize: 10,
                              ),),
                          //  trailing: Icon(Icons.done),
                        ),
                        ListTile(
                          dense: true,
                          leading: Icon(Icons.reorder,size: 20.0,color: blackColor,),
                          title: Text('Unlimited orders',textScaleFactor: 1.5,style: TextStyle(color: blackColor, fontSize: 10,
                              ),),
                          //  trailing: Icon(Icons.done),
                        ),
                        ListTile(
                          dense: true,
                          leading: Icon(Icons.remove_red_eye,size: 20.0,color: blackColor,),
                          title: Text('Unlimited visitors',textScaleFactor: 1.5,style: TextStyle(color: blackColor, fontSize: 10,
                             ),),
                          //  trailing: Icon(Icons.done),
                        ),

                      ],
                    )
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors
                            .transparent, //remove color to make it transpatent
                        border: Border.all(
                            style: BorderStyle.solid, color: Colors.transparent)),
                    child:   ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 0,top: 5.0),
                            padding: new EdgeInsets.all(1.0),
                            width: MediaQuery.of(context).size.width,
                            height: 20,
                            child:  Center(
                              child:  Text(
                                "\u{20B9} 4000.00",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style:
                                TextStyle(color: blueColor, fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 0,top: 5.0),

                            width: MediaQuery.of(context).size.width,
                            height: 20,
                            child:  Center(
                              child:  Text(
                                "12 month validity",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,

                                style:
                                TextStyle(color: blueColor, fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,letterSpacing: 1.0),
                              ),
                            )
                        ),

                        Container(
                          margin: EdgeInsets.only(bottom: 0,top: 5.0,left: 30.0,right: 30.0),
                          padding: new EdgeInsets.all(5.0),
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child:  FlatButton(
                            onPressed: (){
                              openCheckout("4000","12 Month");
                            },
                            // padding: EdgeInsets.all(25.0),
                            color: buttonColor,
                            shape: StadiumBorder(),
                            child:  Text(
                              S.of(context).buyNow,
                              style: TextStyle(color: Theme.of(context).primaryColor,
                                  fontWeight:FontWeight.bold ,
                                  fontSize: 20.0),
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 0,top: 5.0),

                            width: MediaQuery.of(context).size.width,
                            height: 20,
                            child:  Center(
                              child:  Text(
                                "Compare with other plans",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style:
                                TextStyle(color: blueColor, fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                        ),
                        new SizedBox(
                          height: 20.0,
                        ),
                        ListTile(
                          dense: true,
                          leading: Icon(Icons.border_outer_outlined,size: 20.0,color: blackColor,),
                          title: Text('Unlimited catalouges',textScaleFactor: 1.5,style: TextStyle(color: blackColor, fontSize: 10,
                           ),),
                          //  trailing: Icon(Icons.done),
                        ),
                        ListTile(
                          dense: true,
                          leading: Icon(Icons.enhance_photo_translate_sharp,size: 20.0,color: blackColor,),
                          title: Text('Unlimited products',textScaleFactor: 1.5,style: TextStyle(color: blackColor, fontSize: 10,
                              ),),
                          //  trailing: Icon(Icons.done),
                        ),
                        ListTile(
                          dense: true,
                          leading: Icon(Icons.reorder,size: 20.0,color: blackColor,),
                          title: Text('Unlimited orders',textScaleFactor: 1.5,style: TextStyle(color: blackColor, fontSize: 10,
                            ),),
                          //  trailing: Icon(Icons.done),
                        ),
                        ListTile(
                          dense: true,
                          leading: Icon(Icons.remove_red_eye,size: 20.0,color: blackColor,),
                          title: Text('Unlimited visitors',textScaleFactor: 1.5,style: TextStyle(color: blackColor, fontSize: 10,
                             ),),
                          //  trailing: Icon(Icons.done),
                        ),

                      ],
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getTab(index, child) {
    return Tab(
      child: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
          //    borderRadius: BorderRadius.(20),
              border: Border.all(color: Colors.blue, width: 1)),
          child: Align(
            alignment: Alignment.center,
            child: child,
          ),
          // child: child,
          // decoration: BoxDecoration(
          //     color:
          //         (_selectedTab == index ? blueColor : Colors.transparent),
          //     borderRadius: _generateBorderRadius(index)),
        ),
      ),
    );
  }


}
