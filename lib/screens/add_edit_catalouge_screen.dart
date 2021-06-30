import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:sell_right/constant/app_properties.dart';
import 'package:sell_right/controller/product_controller.dart';
import 'package:sell_right/models/products_provider.dart';
import '../helpers/app_config.dart' as config;
import '../generated/l10n.dart';
import '../elements/BlockButtonWidget.dart';
class AddEditCatalougeScreen extends StatefulWidget {
  final catalougeId;
  AddEditCatalougeScreen({Key key,this.catalougeId}):super(key: key);
  @override
  _AddEditCatalougeScreenState createState() => _AddEditCatalougeScreenState();
}

class _AddEditCatalougeScreenState extends StateMVC<AddEditCatalougeScreen> {
ProductController _con;
var _isLoaded = false;
String cat_title1;
TextEditingController _emailController=new TextEditingController();
final cat_controller = TextEditingController();
_AddEditCatalougeScreenState() : super(ProductController()) {
  _con = controller;
}

  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    if (widget.catalougeId != 'add') {

    }
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(

          'Add Catalouge',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white,),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: _isLoaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          :
    Container(
    height: config.App(context).appHeight(100),
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets/my_Catalouge_Back.jpg'), fit: BoxFit.cover)),
      child:Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _con.catFormKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 80,
                      ),
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Theme.of(context).focusColor.withOpacity(0.7),
                                  Theme.of(context).focusColor.withOpacity(0.05),
                                ])),
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
                      SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        // initialValue:
                        //     widget.catalougeId != 'add' ? _con.productdata.catalougeName : '',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        controller: _emailController,
                        style: TextStyle(
                          color: blackColor
                        ),
                        decoration: InputDecoration(
                          labelText: S.of(context).addCatalougeName,
                          labelStyle: TextStyle(color: Colors.black),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'Example',
                          hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.5)),

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
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context).requestFocus(_priceFocusNode);
                        // },
                        onSaved: (value) {
                           // cat_controller.=value;
                          cat_title1=value;
                        },
                        validator: (value) {
                          if (value.isEmpty||value==""||value.length==0) {
                            return 'Please enter title';
                          }
                          return null; // null mean no error
                        },
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      // Expanded(
                      //   flex: 2,
                      //   child: Align(
                      //     alignment: FractionalOffset.bottomCenter,
                      //     child: RaisedButton(
                      //       color: buttonColor,
                      //       onPressed: (){
                      //         _con.createCatalouge(_con.productdata.catalougeName);
                      //       },
                      //       child: Text(
                      //         widget.catalougeId != 'add' ? 'Save' : 'Add',
                      //         style: TextStyle(color: Colors.white),
                      //       ),
                      //     )
                      //   ),
                      // ),
                      // Expanded(
                      //   flex: 1,
                      //   child: Placeholder(),
                      // ),


                      Container(
                          margin: EdgeInsets.only(bottom: 0),
                          width: MediaQuery.of(context).size.width,
                        height: 60,
                        child:   BlockButtonWidget(

                          text: Text(
                            S.of(context).add,
                            style: TextStyle(color: Theme.of(context).primaryColor),
                          ),
                          color: buttonColor,
                          onPressed: () {
                            _con.createCatalouge(cat_title1);

                          },
                        ),
                      ),
                      _btnDelete(),
                    ],
                  ),
                ),
              ),
            )),
    );
  }

  Widget _btnDelete() {
    if (widget.catalougeId != 'add') {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: RaisedButton(
          color: Colors.red,
          onPressed: () {
            Provider.of<ProductsProvider>(context, listen: false)
                .deleteProduct(widget.catalougeId);
            Navigator.of(context).pop();
          },
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
