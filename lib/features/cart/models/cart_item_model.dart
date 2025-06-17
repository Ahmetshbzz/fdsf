import '../../../features/products/models/product_model.dart';

class CartItem {
  final int id;
  final Product product;
  final int quantity;
  final double price; // Ürün fiyatı (indirimli fiyat varsa o kullanılır)
  final double? unitPrice; // Birim fiyat (toptan alım için)
  final double? totalPrice; // Toplam fiyat (quantity * price)
  final String? note; // Sepet öğesi için not

  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.price,
    this.unitPrice,
    this.totalPrice,
    this.note,
  });

  // JSON'dan model oluşturma
  factory CartItem.fromJson(Map<String, dynamic> json, {Product? product}) {
    return CartItem(
      id: json['id'],
      product: product ?? Product.fromJson(json['product']),
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      unitPrice: json['unit_price']?.toDouble(),
      totalPrice: json['total_price']?.toDouble(),
      note: json['note'],
    );
  }

  // Model'den JSON oluşturma
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': product.id,
      'quantity': quantity,
      'price': price,
      'unit_price': unitPrice,
      'total_price': calculateTotalPrice(),
      'note': note,
    };
  }

  // Toplam fiyat hesaplama
  double calculateTotalPrice() {
    return quantity * price;
  }

  // Sepet öğesini güncelleme
  CartItem copyWith({
    int? id,
    Product? product,
    int? quantity,
    double? price,
    double? unitPrice,
    double? totalPrice,
    String? note,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      note: note ?? this.note,
    );
  }

  // Miktar artırma
  CartItem incrementQuantity() {
    return copyWith(
      quantity: quantity + 1,
      totalPrice: (quantity + 1) * price,
    );
  }

  // Miktar azaltma
  CartItem decrementQuantity() {
    if (quantity <= 1) {
      return this;
    }
    return copyWith(
      quantity: quantity - 1,
      totalPrice: (quantity - 1) * price,
    );
  }
}
