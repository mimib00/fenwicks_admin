class Product {
  final String uid;
  final String name;
  final String description;
  final String category;
  final int points;
  final int bounus;
  final double price;
  final int quantity;
  final int servings;
  final int sku;
  final int rating;
  final int level;

  Product(
    this.uid,
    this.name,
    this.description,
    this.category,
    this.points,
    this.bounus,
    this.price,
    this.quantity,
    this.servings,
    this.sku,
    this.rating,
    this.level,
  );

  factory Product.fromJson(Map<String, dynamic> data, String uid) {
    return Product(
      uid,
      data["name"],
      data["description"],
      data["category"],
      data["points"],
      data["bounus"],
      double.parse(data["price"].toString()),
      data["quantity"],
      data["servings"],
      data["sku"],
      data["rating"],
      data["level"],
    );
  }
}
