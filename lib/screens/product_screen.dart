import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sell_right/constant/app_properties.dart';
import 'package:sell_right/controller/product_controller.dart';
import 'package:sell_right/elements/CircularLoadingWidget.dart';
import 'package:sell_right/generated/l10n.dart';
import '../helpers/app_config.dart' as config;
import 'package:sell_right/models/Product.dart';
import '../repository/user_repository.dart' as userRepo;
import '../models/route_argument.dart';
import '../elements/EmptyCartWidget.dart';

class ProductScreen extends StatefulWidget {
  final RouteArgument routeArgument;
  ProductScreen({Key key, this.routeArgument}) : super(key: key);
  @override
  _MyProductScreenScreen createState() => _MyProductScreenScreen();
}

class _MyProductScreenScreen extends StateMVC<ProductScreen> {
  ProductController _con;

  _MyProductScreenScreen() : super(ProductController()) {
    _con = controller;
  }
  @override
  void initState() {
    _con.listenForProducts(
        userRepo.currentUser.value.id, widget.routeArgument.id);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          S.of(context).product,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: config.App(context).appHeight(100),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/my_Catalouge_Back.jpg'),
                fit: BoxFit.cover)),
        child: Stack(
          children: <Widget>[
            _con.productView.isEmpty
                ? EmptyCatlougeWidget(text: S.of(context).dont_have_any_product)
                : Container(
              padding: EdgeInsets.all(8.0),
                    child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (ctx, index) {
                      // return catalougeData(wonders[index], context);
                      return productData(_con.productView[index], context);
                    },
                    itemCount: _con.productView.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 5);
                    },
                  )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.add),
        backgroundColor: buttonColor,
        onPressed: () {
          setState(() {
            Navigator.of(context).pushNamed('/AddProductEditScreen',
                arguments: widget.routeArgument.id);
          });
        },
      ),
    );
  }

  Widget productData(AllProduct product, BuildContext context) {
    return product != null
        ? Container(
            margin: new EdgeInsets.all(8.0),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),

            decoration: BoxDecoration(
              border: Border.all(color: darkGrey, width: 1.0),
              borderRadius: BorderRadius.all(
                  Radius.circular(5.0) //         <--- border radius here
              ),
              color: Theme.of(context).primaryColor.withOpacity(1.0),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).focusColor.withOpacity(0.6),
                    blurRadius: 5,
                    offset: Offset(0, 2)),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                        image: product.image.image != null
                            ? NetworkImage(product.image.image)
                            : Image.asset('assets/my_Catalouge_Back.jpg'),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 15),
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              product.productName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style:
                              TextStyle(color: blueColor, fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              product.description,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(
                              height: 8,
                              width: 16,
                            ),
                            Text(
                              product.price,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15.0),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   crossAxisAlignment: CrossAxisAlignment.end,
                            //   children: [
                            //     // Container(
                            //     //   width: 27,
                            //     //   // decoration: BoxDecoration(
                            //     //   //   border: Border.all(
                            //     //   //       color: Colors.grey, width: 2),
                            //     //   //   color: Colors.transparent,
                            //     //   //   shape: BoxShape.circle,
                            //     //   // ),
                            //     //   child: IconButton(
                            //     //     iconSize: 15,
                            //     //     icon: Icon(
                            //     //       Icons.edit,
                            //     //       color: buttonColor,
                            //     //     ),
                            //     //     onPressed: () {},
                            //     //   ),
                            //     // ),
                            //     SizedBox(
                            //       width: 5,
                            //     ),
                            //     Container(
                            //       width: 27,
                            //       // decoration: BoxDecoration(
                            //       //   border: Border.all(
                            //       //       color: Colors.grey, width: 2),
                            //       //   color: Colors.transparent,
                            //       //   shape: BoxShape.circle,
                            //       // ),
                            //       child: IconButton(
                            //         iconSize: 15,
                            //         icon: Icon(Icons.arrow_forward_ios,
                            //             color: buttonColor),
                            //         onPressed: () {},
                            //       ),
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container(
            child: Text("No Data Found!!!"),
          );
  }
}
