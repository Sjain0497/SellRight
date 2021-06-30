import 'dart:convert';
import 'dart:io';

import '../models/Order.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../helpers/helper.dart';

import '../models/user.dart';
import '../repository/user_repository.dart' as userRepo;

Future<Stream<Order>> getOrders() async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Stream.value(null);
  }
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      // '${GlobalConfiguration().getValue('api_base_url')}orders?${_apiToken}with=user;foodOrders;foodOrders.food;foodOrders.extras;orderStatus;payment&search=user.id:${_user.id}&searchFields=user.id:=&orderBy=id&sortedBy=desc';
      '${GlobalConfiguration().getValue('api_base_url')}order_details?vid=${_user.id}';
  print("OrderData...$url");
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) {
    print("Response....${data}");
    return Order.fromJSON(data);
  });
}

Future<Stream<Order>> getOrder(orderId) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Stream.value(null);
  }
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      // '${GlobalConfiguration().getValue('api_base_url')}orders/$orderId?${_apiToken}with=user;foodOrders;foodOrders.food;foodOrders.extras;orderStatus;deliveryAddress;payment';
      '${GlobalConfiguration().getValue('api_base_url')}singleorder_detail?order_id=$orderId';
  print("GetOrderUrl...$url");
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .map((data) {
    print("OrderUrlData...$data");
    return Order.fromJSON(data);
  });
}

Future<Stream<Order>> cancelOrder(Order order,String dropdownValue) async {
    print("DropDownValue...${order.order_id}");
  User _user = userRepo.currentUser.value;

  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}order_status?order_id=${order.order_id}&order_status=$dropdownValue';
    print("DropDownValueURL...${url}");
  final client = new http.Client();
  final streamedRest = await client.send(
    http.Request('get',Uri.parse(url)),

  );
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .map((data) {
      print("OrderStatusData...$data");
      return Order.fromJSON(data);
    });
}
