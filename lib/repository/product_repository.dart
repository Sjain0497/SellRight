import 'dart:convert';

import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http_parser/http_parser.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:sell_right/helpers/custom_trace.dart';
import 'package:sell_right/models/Product.dart';
import 'package:sell_right/models/productData.dart';
import 'package:sell_right/models/user.dart';
import 'package:http/http.dart' as http;
import '../helpers/helper.dart';
import '../models/Catalouge.dart';
import '../repository/user_repository.dart' as userRepo;
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<Productdata> productData = new ValueNotifier(Productdata());
ValueNotifier<Catalouge> catalougeData = new ValueNotifier(Catalouge());
Future<Productdata> createCatalogue(String cat_Title) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}createcatalouge';
  print("registerUrl..$url");
  print("id...${userRepo.currentUser.value.id + cat_Title}");
  final client = new http.Client();
  final response = await client.post(url, body: {
    "vid": userRepo.currentUser.value.id,
    "catalogue_name": cat_Title
  });

  print("RegisterResponseUser....${response.body}");
  if (response.statusCode == 200) {
    productData.value =
        Productdata.fromJson(json.decode(response.body)['data']);

    print("productValue...$productData");
  } else {
    print(CustomTrace(StackTrace.current, message: response.body).toString());
    throw new Exception(response.body);
  }
  return Productdata.fromJson(json.decode(response.body)['data']);
}

//remove Catalouge
Future<bool> removeCatalouge(Catalouge cart) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return false;
  }
  final String _apiToken = 'api_token=${_user.apiToken}';
  final String catId=cart.catalougeId;
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}catalogue_delete?cid=$catId';
  print("RemoveCarturl...$url");
  final client = new http.Client();
  // final response = await client.delete(
  //   url,
  //   headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  // );
  final response = await client.get(
    url,

    //headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  );
  print("RemoveResponse..${response.body}");
  return Helper.getBoolData(json.decode(response.body));
}
Future<Stream<Catalouge>> getAllCatalougeData(String vendorId) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}allcatalogue?vid=$vendorId';
  // Uri uri = Helper.getUri('api/allcatalogue?vid=$vendorId');
  print("registerUrl..$url");
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  try {
    // catalougeData.value = Catalouge.fromJson(json.decode(response.body)['data']);
    // print("ResponseOfcata...${response.body}");
    // setCurrentProduct(response.body);
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => Catalouge.fromJson(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url.toString()));
    return new Stream.value(new Catalouge.fromJson({}));
  }
}

//createProduct
Future<Productdata> createProduct(String cat_Title, String price,
    String description, List<Asset> imageFilesList, String productId) async {
  print("ImageFiles....$imageFilesList");
  if (imageFilesList != null) {
    for (var i = 0; i < imageFilesList.length; i++) {
      final String url =
          '${GlobalConfiguration().getValue('api_base_url')}addproduct';

      ByteData byteData = await imageFilesList[i].getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      //MultipartFile multipartFile=MultipartFile.fromBytes('imageData', filename:imageFilesList[i].name);
      MultipartFile multipartFile = MultipartFile.fromBytes(
        imageData,
        filename: imageFilesList[i].name,
        contentType: MediaType('image', 'jpg'),
      );
      print("..id...${imageFilesList[i].name}");

      FormData formData = FormData.fromMap({
        "image": multipartFile,
        "vid": userRepo.currentUser.value.id.toString(),
        "cid": productId,
        "product_name": cat_Title,
        "price": price,
        "description": description
      });
      print("FormData...${jsonEncode(formData.toString())}");
      var response = await Dio().post(url, data: formData);

      print(response);
      print("ProductResponseUser....${response.data}");
      if (response.statusCode == 200) {
      } else {
        print(
            CustomTrace(StackTrace.current, message: response.data).toString());
        throw new Exception(response.data);
      }
      return Productdata.fromJson(json.decode(response.data)['data']);
    }
  }
}
//All product view
Future<Stream<AllProduct>> getAllProduct(String vendorId,String catalougeId) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}allproduct?vid=$vendorId&cid=$catalougeId';

  print("getAllProductUrl..$url");
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  try {
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => AllProduct.fromJson(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url.toString()));
    return new Stream.value(new AllProduct.fromJson({}));
  }
}
///remove product
//remove Catalouge
Future<bool> removeProduct(Catalouge cart) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return false;
  }
  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}addcart2';
  print("RemoveCarturl...$url");
  final client = new http.Client();
  // final response = await client.delete(
  //   url,
  //   headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  // );
  final response = await client.post(
    url,
    body: {
      "cid": cart.catalougeId,
    },
    //headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  );
  print("RemoveResponse..${response.body}");
  return Helper.getBoolData(json.decode(response.body));
}
void setCurrentProduct(jsonString) async {
  try {
    if (json.decode(jsonString)['data'] != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'current_product', json.encode(json.decode(jsonString)['data']));
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: jsonString).toString());
    throw new Exception(e);
  }
}

Future<Catalouge> getCurrentProduct() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  if (catalougeData.value == null && prefs.containsKey('current_product')) {
    catalougeData.value =
        Catalouge.fromJson(json.decode(await prefs.get('current_product')));
  } else {
    //productData.value = false;
  }
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  catalougeData.notifyListeners();
  return catalougeData.value;
}
