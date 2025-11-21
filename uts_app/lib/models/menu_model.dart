// lib/models/menu_model.dart

class MenuModel {
  final String id;
  final String name;
  final int price;
  final String category;
  final double discount; // nilai antara 0-1

  MenuModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.discount = 0.0,
  });

  // Metode untuk mendapatkan harga setelah diskon
  int getDiscountedPrice() {
    return (price - (price * discount)).toInt();
  }

  // Helper method untuk mendapatkan nilai diskon dalam rupiah
  int getDiscountAmount() {
    return (price * discount).toInt();
  }

  // Helper method untuk cek apakah ada diskon
  bool hasDiscount() {
    return discount > 0;
  }

  // CopyWith untuk immutability
  MenuModel copyWith({
    String? id,
    String? name,
    int? price,
    String? category,
    double? discount,
  }) {
    return MenuModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      discount: discount ?? this.discount,
    );
  }
}