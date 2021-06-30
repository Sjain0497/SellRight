import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:sell_right/constant/app_properties.dart';
import 'package:sell_right/controller/product_controller.dart';
import 'package:sell_right/helpers/custom_trace.dart';
import '../models/products_provider.dart';
import '../generated/l10n.dart';
import 'package:dio/dio.dart';
import 'package:global_configuration/global_configuration.dart';
import '../repository/user_repository.dart' as userRepo;
import 'dart:typed_data';
import '../elements/BlockButtonWidget.dart';
import '../helpers/app_config.dart' as config;
import 'ImageUpload.dart';
import '../constant/network_utils.dart';
import '../constant/method_utils.dart';

class AddEditProductScreen extends StatefulWidget {
  final productId;
  AddEditProductScreen({Key key, this.productId}) : super(key: key);
  @override
  _AddEditProductScreenState createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  File file;
  String status = '';
  String base64Image, base64Image1, base64Image2, base64Image3, base64Image4;
  File tmpFile, tmpFile1, tmpFile2, tmpFile3, tmpFile4;
  String errMessage = 'Error Uploading Image';

  Future<File> _imageFile, _imageFile1, _imageFile2, _imageFile3, _imageFile4;
  final product_name = TextEditingController(text: '');
  final product_description = TextEditingController(text: '');
  final product_price = TextEditingController(text: '');
  String productName, productPrice, productDesc;

  var _isLoaded = false;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  chooseImage() {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  chooseImage1() {
    setState(() {
      _imageFile1 = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  chooseImage2() {
    setState(() {
      _imageFile2 = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  chooseImage3() {
    setState(() {
      _imageFile3 = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  chooseImage4() {
    setState(() {
      _imageFile4 = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      print("hi11........");
      status = message;
    });
  }

  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile ||
        null == tmpFile1 ||
        null == tmpFile2 ||
        null == tmpFile3 ||
        null == tmpFile4) {
      print("hi........$tmpFile");

      setStatus(errMessage);
      //return;
    }

    print("hinewww........$tmpFile1");

    String fileName = tmpFile.path.split('/').last;
    print("filename..${fileName}");
    String fileName1, fileName2, fileName3, fileName4;

    if (tmpFile1 == null) {
      fileName1 = "";
      base64Image1 = "";
    } else {
      fileName1 = tmpFile1.path.split('/').last;
    }
    if (tmpFile2 == null) {
      fileName2 = "";
      base64Image2 = "";
    } else {
      fileName2 = tmpFile2.path.split('/').last;
    }
    if (tmpFile3 == null) {
      fileName3 = "";
      base64Image3 = "";
    } else {
      fileName3 = tmpFile3.path.split('/').last;
    }
    if (tmpFile4 == null) {
      fileName4 = "";
      base64Image4 = "";
    } else {
      print("filenameElse..${tmpFile1}");

      fileName4 = tmpFile4.path.split('/').last;
    }

    print("filename3333..${fileName1}");
    print("filename3333..${fileName}");
    onSaved(fileName, fileName1, fileName2, fileName3, fileName4);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _con.scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Add Product',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: _isLoaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: config.App(context).appHeight(100),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/my_Catalouge_Back.jpg'),
                      fit: BoxFit.cover)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  // key: _con.catFormKey,
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
                                    Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.7),
                                    Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.05),
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
                          style: TextStyle(color: Colors.black),
                          controller: product_name,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            hintText: 'Title',
                            hintStyle: Theme.of(context).textTheme.body2,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.8))),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                          onSaved: (value) {
                            productName = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter product name';
                            }
                            return null; // null mean no error
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          controller: product_description,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            hintText: S.of(context).description,
                            hintStyle: Theme.of(context).textTheme.body2,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.8))),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                          onSaved: (value) {
                            productDesc = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter product description';
                            }
                            return null; // null mean no error
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: product_price,

                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            hintText: S.of(context).price,
                            hintStyle: Theme.of(context).textTheme.body2,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.8))),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2.0,
                              ),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),

                          // onFieldSubmitted: (_) {
                          //   FocusScope.of(context).requestFocus(_priceFocusNode);
                          // },
                          onSaved: (value) {
                            productPrice =
                                value; //_con.productdata.catalougeName  = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter price of the product';
                            }
                            return null; // null mean no error
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        SizedBox(
                          height: 60.0,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                  margin: new EdgeInsets.all(10.0),
                                  height: 40.0,
                                  width: 50.0,
                                  child: Text(
                                    "Add Images :-",
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12.0),
                                  )),
                              _imageFile == null
                                  ? Container(
                                      height: 50.0,
                                      width: 50.0,
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        child: IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            chooseImage();
                                          },
                                        ),
                                      ),
                                    )
                                  : showImage(),
                              SizedBox(
                                height: 20.0,
                              ),
                              _imageFile1 == null
                                  ? Container(
                                      height: 50.0,
                                      width: 50.0,
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        child: IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            chooseImage1();
                                          },
                                        ),
                                      ),
                                    )
                                  : showImage1(),
                              SizedBox(
                                height: 20.0,
                              ),
                              _imageFile2 == null
                                  ? Container(
                                      height: 50.0,
                                      width: 50.0,
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        child: IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            chooseImage2();
                                          },
                                        ),
                                      ),
                                    )
                                  : showImage2(),
                              SizedBox(
                                height: 20.0,
                              ),
                              _imageFile3 == null
                                  ? Container(
                                      height: 50.0,
                                      width: 50.0,
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        child: IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            chooseImage3();
                                          },
                                        ),
                                      ),
                                    )
                                  : showImage3(),
                              SizedBox(
                                height: 20.0,
                              ),
                              _imageFile4 == null
                                  ? Container(
                                      height: 20.0,
                                      width: 50.0,
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        child: IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            chooseImage4();
                                          },
                                        ),
                                      ),
                                    )
                                  : showImage4(),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: BlockButtonWidget(
                            text: Text(
                              S.of(context).add,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            color: buttonColor,
                            onPressed: () {
                              startUpload();
                            },
                          ),
                        ),
                        //  _btnDelete(),
                      ],
                    ),
                  ),
                ),
              )),
    );
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: _imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          print("Base64...$base64Image");
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          );
        }
      },
    );
  }

  Widget showImage1() {
    return FutureBuilder<File>(
      future: _imageFile1,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile1 = snapshot.data;
          base64Image1 = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  Widget showImage2() {
    return FutureBuilder<File>(
      future: _imageFile2,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile2 = snapshot.data;
          base64Image2 = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  Widget showImage3() {
    return FutureBuilder<File>(
      future: _imageFile3,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile3 = snapshot.data;
          base64Image3 = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  Widget showImage4() {
    return FutureBuilder<File>(
      future: _imageFile4,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile4 = snapshot.data;
          base64Image4 = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  void onSaved(String filename, String filename1, String filename2,
      String filename3, String filename4) async {
    if (base64Image == null && filename == "") {
      Fluttertoast.showToast(msg: 'Please add image');
    } else {
      print("Imagesname...${filename2.toString()}");
      String url =
          '${GlobalConfiguration().getValue('api_base_url')}addproduct';
      print("Url....$url");
      final client = new http.Client();
      final response = await client.post(url, body: {
        "image1": base64Image,
        "image2": base64Image1.toString(),
        "image3": base64Image2.toString(),
        "image4": base64Image3.toString(),
        "image5": base64Image4.toString(),
        "name1": filename,
        "name2": filename1.toString(),
        "name3": filename2.toString(),
        "name4": filename3.toString(),
        "name5": filename4.toString(),
        "vid": userRepo.currentUser.value.id.toString(),
        "cid": widget.productId,
        "product_name": product_name.text.toString(),
        "price": product_price.text.toString(),
        "description": product_description.text.toString()
      });
      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacementNamed('/Home');
        print("response...${response.body}");
      } else {
        print("not found");
      }
    }
  }
}
