class ProductModel {
  int? id;
  String? title;
  String? description;
  int? price;

  ProductModel({
    this.id,
    this.title,
    this.description,
    this.price,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        price: map['price'],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
      };
}
