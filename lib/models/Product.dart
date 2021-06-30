
import 'package:sell_right/models/Image.dart';

class AllProduct{
  String pid;
  String cid;
  String vid;
  String productName;
  String price;
  String description;
  Image image;
  String createdAt;
  String updatedAt;

  AllProduct(
      {this.pid,
        this.cid,
        this.vid,
        this.productName,
        this.price,
        this.description,
        this.image,
        this.createdAt,
        this.updatedAt});

  AllProduct.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    cid = json['cid'];
    vid = json['vid'];
    productName = json['product_name'];
    price = json['price'];
    description = json['description'];
    image = json['image'] != null && (json['image'] as List).length > 0 ? Image.fromJson(json['image'][0]) : new Image();

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['cid'] = this.cid;
    data['vid'] = this.vid;
    data['product_name'] = this.productName;
    data['price'] = this.price;
    data['description'] = this.description;

    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

}