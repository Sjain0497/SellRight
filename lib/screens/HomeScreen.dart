import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:share/share.dart';
import '../helpers/app_config.dart' as config;
import '../constant/app_properties.dart';
import '../generated/l10n.dart';
import '../controller/product_controller.dart';
import '../models/Catalouge.dart';
import '../elements/EmptyCartWidget.dart';
import '../repository/product_repository.dart' as productrepo;
import '../models/route_argument.dart';
import 'dart:async';
import 'homeWithPlanData.dart';

class HomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenScreen createState() => _MyHomeScreenScreen();
}

class _MyHomeScreenScreen extends StateMVC<HomeScreen>
    with SingleTickerProviderStateMixin {
  ProductController _con;
  bool loading = true;
  TabController _tabController;

  int _selectedTab = 0;

  _MyHomeScreenScreen() : super(ProductController()) {
    _con = controller;
    productrepo.getCurrentProduct();
  }
  @override
  void initState() {
    // _tabController = TabController(vsync: this, length: 3);
    //
    // _tabController.addListener(() {
    //   if (!_tabController.indexIsChanging) {
    //     setState(() {
    //       _selectedTab = _tabController.index;
    //     });
    //   }
    // });

    super.initState();
  }
  @override
  void dispose() {

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print({_con.catalouge});
    return WillPopScope(
        onWillPop: () async => false,
      child: Scaffold(
        key: _con.scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            S.of(context).catalouge,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
                Navigator.of(context).pushNamed('/OrdersWidget');
              },
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
                Navigator.of(context).pushNamed('/SettingScreen');
              },
            )
          ],
        ),
        extendBodyBehindAppBar: true,
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
                      'assets/my_Catalouge_Back.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                  /* color: Theme.of(context).accentColor*/
                ),
                //decoration: BoxDecoration(color: Theme.of(context).accentColor),
              ),
            ),
            // Positioned(
            //   top: config.App(context).appHeight(29.5) - 140,
            //   child: Container(
            //     width: config.App(context).appWidth(44),
            //     height: config.App(context).appHeight(8.5),
            //     child: Image.asset(
            //       'assets/white_logo.png',
            //       width: 20,
            //       fit: BoxFit.contain,
            //     ),
            //   ),
            // ),

            // Positioned(
            //   top: 140,
            // child: ),
            _con.catalouge.isEmpty
                ? EmptyCatlougeWidget(text:  S.of(context).dont_have_any_catalouge,)
                : Container(
                padding: EdgeInsets.all(8.0),
                width: config.App(context).appWidth(100),
                height: config.App(context).appHeight(100),
                child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    return catalougeData(
                        _con.catalouge[index], context, index);
                  },
                  itemCount: _con.catalouge.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 5);
                  },
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          // isExtended: true,
          child: Icon(Icons.add),
          backgroundColor: buttonColor,
          onPressed: () {
            setState(() {
              Navigator.of(context)
                  .pushNamed('/AddCatalougeEditScreen', arguments: 'add');
            });
          },
        ),
      )
    );
  }

  Widget catalougeData(Catalouge product, BuildContext context, int index) {
    print("Productdata...${(product.catalougeName)}");
    return product != null
        ? product.flag == "0" || product.flag == "1"
            ? Container(
                margin: new EdgeInsets.all(10.0),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(1.0),
                  border: Border.all(color: darkGrey, width: 1.0),
                  borderRadius: BorderRadius.all(
                      Radius.circular(5.0) //         <--- border radius here
                      ),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).focusColor.withOpacity(0.5),
                        blurRadius: 5,
                        offset: Offset(0, 2)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 10),
                    Flexible(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Text(
                                      "Catalouge Name :- ",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: blueColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      product.catalougeName ?? "Catalouge Name",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: blueColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      "Link :- ",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: blackColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 10),
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      child: Text(
                                        product.catalogueLink,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: darkGrey, fontSize: 12),
                                      ),
                                    ),
                                    // Text(
                                    //   product.catalogueLink,
                                    //   overflow: TextOverflow.ellipsis,
                                    //   maxLines: 2,
                                    //   style:
                                    //       TextStyle(color: darkGrey, fontSize: 10),
                                    // ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 35,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: lightGrey, width: 2),
                                        color: Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        iconSize: 17,
                                        icon: Icon(
                                          Icons.share,
                                          color: buttonColor,
                                        ),
                                        onPressed: () {
                                          Share.share(
                                              product.catalogueLink.toString());
                                        },
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width: 5,
                                    // ),
                                    // Container(
                                    //   width: 35,
                                    //   decoration: BoxDecoration(
                                    //     border: Border.all(
                                    //         color: lightGrey, width: 2),
                                    //     color: Colors.transparent,
                                    //     shape: BoxShape.circle,
                                    //   ),
                                    //   child: IconButton(
                                    //     iconSize: 18,
                                    //     icon: Icon(
                                    //       Icons.edit,
                                    //       color: buttonColor,
                                    //     ),
                                    //     onPressed: () {
                                    //
                                    //     },
                                    //   ),
                                    // ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      width: 35,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: lightGrey, width: 2),
                                        color: Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        iconSize: 17,
                                        icon: Icon(
                                          Icons.delete,
                                          color: buttonColor,
                                        ),
                                        onPressed: () {
                                          _con.removeFromCart(
                                              _con.catalouge.elementAt(index));
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      width: 35,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: lightGrey, width: 2),
                                        color: Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        iconSize: 18,
                                        icon: Icon(Icons.arrow_forward_ios,
                                            color: buttonColor),
                                        onPressed: () {
                                          print(
                                              "idOfProduct....${product.catalougeId}");
                                          Navigator.of(context).pushNamed(
                                              '/ProductScreen',
                                              arguments: RouteArgument(
                                                  id: product.catalougeId));
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 5),
                          // Helper.getPrice(food.price, context, style: Theme.of(context).textTheme.headline4),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              )
            : /*HomeWithPlanScreen()*/   Future.delayed(Duration.zero, () async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeWithPlanScreen()));
    })
        : Center(
            child: Text(
            "\tNo any catalouge here.\nAdd from plus button !!! Enjoy",
            style: TextStyle(
                color: darkGrey, fontSize: 15, fontWeight: FontWeight.bold),
          ));
  }
}
