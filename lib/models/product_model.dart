class Product {
  final int? id;
  final String title;
  final double? cost;
  final double? price;
  final int? stock;
  final String? email;

  const Product({this.title="", this.cost, this.price, this.stock, this.id, this.email});

  factory Product.fromJson(Map<String, dynamic> json) =>
      Product(
           id: json['id'], 
        title: json['title'],
         cost: json['cost'],
        price: json['price'],
        stock: json['stock'],
        email: json['email']
        );

  Map<String, dynamic> toJson() => {
        'id': id,
     'title': title,
      'cost': cost,
     'price': price,
     'stock': stock,
     'email': email
  };
}
