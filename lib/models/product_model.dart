class Product {
  final int? id;
  final String title;
  final double? cost;
  final double? price;
  final int? stock;

  const Product({this.title="", this.cost, this.price, this.stock, this.id});

  factory Product.fromJson(Map<String, dynamic> json) =>
      Product(
           id: json['id'], 
        title: json['title'],
         cost: json['cost'],
        price: json['price'],
        stock: json['stock'],
        );

  Map<String, dynamic> toJson() => {
        'id': id,
     'title': title,
      'cost': cost,
     'price': price,
     'stock': stock
  };
}
