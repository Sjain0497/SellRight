import 'package:sell_right/helpers/custom_trace.dart';

class Order{
  String order_id;
  String product;
  String description;
  String price;
  String quantity;
  String total_price;
  String order_status;
  String image;
  String uid;
  String username;
  String email;
  String number;
  String address;
  String payment_type;
  String created_at;
  Order.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      order_id = jsonMap['order_id'].toString();
      product = jsonMap['product'] != null ? jsonMap['product'] : '';
      description = jsonMap['description'] != null ? jsonMap['description'] : '';
      price = jsonMap['price'];
      quantity = jsonMap['quantity'];
      total_price=jsonMap['total_price'];
      order_status=jsonMap['order_status']!=null?jsonMap['order_status']:'';
      image=jsonMap['image'];
      uid=jsonMap['uid'];
      username=jsonMap['username'];
      email=jsonMap['email'];
      number=jsonMap['number'];
      payment_type=jsonMap['payment_type'];
      created_at=jsonMap['created_at'];

      try {
        address = jsonMap['address'];
      } catch (e) {
        address = "";
      }

    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}