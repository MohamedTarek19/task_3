class Product {
  String? title;
  int? id;
  String? description;
  int? price;
  String? thumbnail;

  Product({this.id, this.title, this.description, this.price, this.thumbnail});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'] as String?,
      description: json['description'] as String?,
      price: json['price'],
      thumbnail: json['thumbnail'],
    );
  }
}
