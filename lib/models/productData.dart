import 'package:sell_right/helpers/custom_trace.dart';

class Productdata{
  String catalogueId;
  String vendorId;
  String catalougeName;
  String catalogueLink;
  Productdata();
  Productdata.fromJson(Map<String,dynamic> json){
    try{
      catalogueId=json['cid'].toString();
      vendorId=json['vid'];
      catalougeName=json['catalogue_name'];
      catalogueLink=json['link'];
    }
    catch (e) {
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}