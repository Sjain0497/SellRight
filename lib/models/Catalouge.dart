import 'package:sell_right/helpers/custom_trace.dart';

class Catalouge{
  String catalougeId;
  String catalougeName;
  String catalogueLink;
  String flag;
  Catalouge();
  Catalouge.fromJson(Map<String,dynamic> json){
    try{
      catalougeId=json['cid'].toString();

      catalougeName=json['catalogue_name'];
      catalogueLink=json['link'];
      flag=json['flag'];
    }
    catch (e) {
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}