class Product {
  final int? id;
  final String title;

  const Product({required this.title, this.id});

  factory Product.fromJson(Map<String, dynamic> json) =>
      Product(id: json['id'], title: json['title']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
  };
}
