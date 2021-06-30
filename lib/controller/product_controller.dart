import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sell_right/generated/l10n.dart';
import 'package:sell_right/helpers/helper.dart';
import 'package:sell_right/models/Product.dart';
import 'package:sell_right/models/productData.dart';
import '../repository/product_repository.dart' as repo;
import '../repository/user_repository.dart' as userRepo;
import '../models/Catalouge.dart';
class ProductController extends ControllerMVC {
  Productdata productdata = new Productdata();
  OverlayEntry loader;
  GlobalKey<FormState> catFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Catalouge> catalouge = <Catalouge>[];
  List<AllProduct> productView = <AllProduct>[];
  ProductController() {
    loader = Helper.overlayLoader(context);
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    catFormKey = new GlobalKey<FormState>();
    listenForCatalouges(userRepo.currentUser.value.id);

  }
  void createCatalouge(String catlogTitle) {
    print("catlogTitle...$catlogTitle");
    if (catlogTitle!="") {
      catFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repo.createCatalogue(catlogTitle).then((value) {
        if ( value.catalogueLink != null) {
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
            content: Text("Please enter proper details"),
          ));
        }).whenComplete(() {
          Helper.hideLoader(loader);
        });
    }else{
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text("Please enter proper details"),
      ));
    }
  }

  Future<void> listenForCatalouges(String vendorId) async {
    final Stream<Catalouge> stream = await repo.getAllCatalougeData(vendorId);
    stream.listen((Catalouge _category) {
      setState(() => catalouge.add(_category));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }
//listen for catalouge delete
  void removeFromCart(Catalouge _cart) async {
    setState(() {
      this.catalouge.remove(_cart);
    });
    repo.removeCatalouge(_cart).then((value) {

      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(
            S.of(context).the_food_was_removed_from_your_cart(_cart.catalougeName)),
      ));
    });
  }

  //add Products...
  void createProduct(String catlogTitle,String price,String description, List<Asset> imageFilesList, String productId) {
    print("..id...$imageFilesList");
    if (catFormKey.currentState.validate()) {
      catFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repo.createProduct(catlogTitle,price,description,imageFilesList,productId).then((value) {
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
  Future<void> listenForProducts(String vendorId,String catalougeId) async {
    final Stream<AllProduct> stream = await repo.getAllProduct(vendorId,catalougeId);
    stream.listen((AllProduct _allProduct) {
      setState(() => productView.add(_allProduct));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }
}
