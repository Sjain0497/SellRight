class Image {
  String image;

  Image({this.image});

  Image.fromJson(Map<String, dynamic> json) {
    image = json['image1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image1'] = this.image;
    return data;
  }
}