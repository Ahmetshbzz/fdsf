class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final double? discountPrice;
  final String category;
  final String brand;
  final List<String> images;
  final int stock;
  final double rating;
  final int reviewCount;
  final bool isFeatured;
  final bool isNewArrival;
  final bool isBestSeller;
  final String origin; // Menşei (Türk ürünü)
  final String? minimumOrderQuantity; // Minimum sipariş miktarı
  final String? shippingInfo; // Kargo bilgisi
  final Map<String, String>? specifications; // Ürün özellikleri

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.discountPrice,
    required this.category,
    required this.brand,
    required this.images,
    required this.stock,
    required this.rating,
    required this.reviewCount,
    this.isFeatured = false,
    this.isNewArrival = false,
    this.isBestSeller = false,
    required this.origin,
    this.minimumOrderQuantity,
    this.shippingInfo,
    this.specifications,
  });

  // JSON'dan model oluşturma
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      discountPrice: json['discount_price']?.toDouble(),
      category: json['category'],
      brand: json['brand'],
      images: List<String>.from(json['images']),
      stock: json['stock'],
      rating: json['rating'].toDouble(),
      reviewCount: json['review_count'],
      isFeatured: json['is_featured'] ?? false,
      isNewArrival: json['is_new_arrival'] ?? false,
      isBestSeller: json['is_best_seller'] ?? false,
      origin: json['origin'],
      minimumOrderQuantity: json['minimum_order_quantity'],
      shippingInfo: json['shipping_info'],
      specifications: json['specifications'] != null
          ? Map<String, String>.from(json['specifications'])
          : null,
    );
  }

  // Model'den JSON oluşturma
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'discount_price': discountPrice,
      'category': category,
      'brand': brand,
      'images': images,
      'stock': stock,
      'rating': rating,
      'review_count': reviewCount,
      'is_featured': isFeatured,
      'is_new_arrival': isNewArrival,
      'is_best_seller': isBestSeller,
      'origin': origin,
      'minimum_order_quantity': minimumOrderQuantity,
      'shipping_info': shippingInfo,
      'specifications': specifications,
    };
  }

  // İndirim oranını hesaplama
  double? get discountPercentage {
    if (discountPrice == null) return null;
    return ((price - discountPrice!) / price) * 100;
  }

  // İndirimde olup olmadığını kontrol etme
  bool get isOnSale => discountPrice != null && discountPrice! < price;
}
