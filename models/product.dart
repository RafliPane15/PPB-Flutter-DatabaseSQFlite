class Product {
  final int? id;
  final String name;
  final double price;
  final String description;
  final String imagePath;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'imagePath': imagePath,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      description: map['description'],
      imagePath: map['imagePath'],
    );
  }

  Product copyWith({
  int? id,
  String? name,
  double? price,
  String? description,
  String? imagePath,
  }) {
  return Product(
    id: id ?? this.id,
    name: name ?? this.name,
    price: price ?? this.price,
    description: description ?? this.description,
    imagePath: imagePath ?? this.imagePath,
  );
  }

}
