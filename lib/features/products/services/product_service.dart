import 'package:dio/dio.dart';
import '../models/product_model.dart';
import '../../../core/constants/app_constants.dart';

class ProductService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppConstants.baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  // Tüm ürünleri getir
  Future<List<Product>> getProducts() async {
    try {
      // Gerçek API çağrısı
      // final response = await _dio.get('/products');
      // return (response.data['data'] as List).map((e) => Product.fromJson(e)).toList();

      // Örnek veri
      await Future.delayed(const Duration(milliseconds: 800));
      return _getDummyProducts();
    } catch (e) {
      throw Exception('Ürünler yüklenirken hata oluştu: $e');
    }
  }

  // Öne çıkan ürünleri getir
  Future<List<Product>> getFeaturedProducts() async {
    try {
      // Gerçek API çağrısı
      // final response = await _dio.get('/products/featured');
      // return (response.data['data'] as List).map((e) => Product.fromJson(e)).toList();

      // Örnek veri
      await Future.delayed(const Duration(milliseconds: 600));
      return _getDummyProducts()
          .where((product) => product.isFeatured)
          .toList();
    } catch (e) {
      throw Exception('Öne çıkan ürünler yüklenirken hata oluştu: $e');
    }
  }

  // Yeni gelen ürünleri getir
  Future<List<Product>> getNewArrivals() async {
    try {
      // Gerçek API çağrısı
      // final response = await _dio.get('/products/new-arrivals');
      // return (response.data['data'] as List).map((e) => Product.fromJson(e)).toList();

      // Örnek veri
      await Future.delayed(const Duration(milliseconds: 500));
      return _getDummyProducts()
          .where((product) => product.isNewArrival)
          .toList();
    } catch (e) {
      throw Exception('Yeni gelen ürünler yüklenirken hata oluştu: $e');
    }
  }

  // Çok satan ürünleri getir
  Future<List<Product>> getBestSellers() async {
    try {
      // Gerçek API çağrısı
      // final response = await _dio.get('/products/best-sellers');
      // return (response.data['data'] as List).map((e) => Product.fromJson(e)).toList();

      // Örnek veri
      await Future.delayed(const Duration(milliseconds: 700));
      return _getDummyProducts()
          .where((product) => product.isBestSeller)
          .toList();
    } catch (e) {
      throw Exception('Çok satan ürünler yüklenirken hata oluştu: $e');
    }
  }

  // Kategoriye göre ürünleri getir
  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      // Gerçek API çağrısı
      // final response = await _dio.get('/products/category/$category');
      // return (response.data['data'] as List).map((e) => Product.fromJson(e)).toList();

      // Örnek veri
      await Future.delayed(const Duration(milliseconds: 600));
      return _getDummyProducts()
          .where((product) => product.category == category)
          .toList();
    } catch (e) {
      throw Exception('Kategoriye göre ürünler yüklenirken hata oluştu: $e');
    }
  }

  // ID'ye göre ürün getir
  Future<Product> getProductById(int id) async {
    try {
      // Gerçek API çağrısı
      // final response = await _dio.get('/products/$id');
      // return Product.fromJson(response.data['data']);

      // Örnek veri
      await Future.delayed(const Duration(milliseconds: 300));
      final product = _getDummyProducts().firstWhere(
        (product) => product.id == id,
        orElse: () => throw Exception('Ürün bulunamadı'),
      );
      return product;
    } catch (e) {
      throw Exception('Ürün detayları yüklenirken hata oluştu: $e');
    }
  }

  // Ürün ara
  Future<List<Product>> searchProducts(String query) async {
    try {
      // Gerçek API çağrısı
      // final response = await _dio.get('/products/search', queryParameters: {'q': query});
      // return (response.data['data'] as List).map((e) => Product.fromJson(e)).toList();

      // Örnek veri
      await Future.delayed(const Duration(milliseconds: 400));
      final lowercaseQuery = query.toLowerCase();
      return _getDummyProducts().where((product) {
        return product.name.toLowerCase().contains(lowercaseQuery) ||
            product.description.toLowerCase().contains(lowercaseQuery) ||
            product.brand.toLowerCase().contains(lowercaseQuery);
      }).toList();
    } catch (e) {
      throw Exception('Ürün arama sırasında hata oluştu: $e');
    }
  }

  // Ürünleri filtrele
  Future<List<Product>> filterProducts(Map<String, dynamic> filters) async {
    try {
      // Gerçek API çağrısı
      // final response = await _dio.get('/products/filter', queryParameters: filters);
      // return (response.data['data'] as List).map((e) => Product.fromJson(e)).toList();

      // Örnek veri
      await Future.delayed(const Duration(milliseconds: 500));
      List<Product> products = _getDummyProducts();

      // Kategori filtresi
      if (filters.containsKey('category') && filters['category'] != null) {
        products =
            products.where((p) => p.category == filters['category']).toList();
      }

      // Marka filtresi
      if (filters.containsKey('brand') && filters['brand'] != null) {
        products = products.where((p) => p.brand == filters['brand']).toList();
      }

      // Fiyat aralığı filtresi
      if (filters.containsKey('minPrice') && filters['minPrice'] != null) {
        products =
            products.where((p) => p.price >= filters['minPrice']).toList();
      }
      if (filters.containsKey('maxPrice') && filters['maxPrice'] != null) {
        products =
            products.where((p) => p.price <= filters['maxPrice']).toList();
      }

      // Menşei filtresi
      if (filters.containsKey('origin') && filters['origin'] != null) {
        products =
            products.where((p) => p.origin == filters['origin']).toList();
      }

      return products;
    } catch (e) {
      throw Exception('Ürün filtreleme sırasında hata oluştu: $e');
    }
  }

  // Örnek ürün verileri
  List<Product> _getDummyProducts() {
    return [
      Product(
        id: 1,
        name: 'Türk Lokumu - Antep Fıstıklı',
        description:
            'Geleneksel Türk lokumu, Antep fıstığı ile zenginleştirilmiş özel tarif. 500g kutu.',
        price: 120.0,
        discountPrice: 99.90,
        category: 'Şekerleme',
        brand: 'Hacı Bekir',
        images: [
          'https://example.com/images/lokum1.jpg',
          'https://example.com/images/lokum2.jpg',
        ],
        stock: 150,
        rating: 4.8,
        reviewCount: 245,
        isFeatured: true,
        isNewArrival: false,
        isBestSeller: true,
        origin: 'Türkiye',
        minimumOrderQuantity: '10 kutu',
        shippingInfo: '3-5 iş günü içinde kargo',
        specifications: {
          'İçindekiler': 'Şeker, su, nişasta, Antep fıstığı, sitrik asit',
          'Raf Ömrü': '6 ay',
          'Saklama Koşulları': 'Serin ve kuru yerde saklayınız',
          'Menşei': 'İstanbul, Türkiye',
        },
      ),
      Product(
        id: 2,
        name: 'El Dokuma Halı - Hereke',
        description:
            'Geleneksel Türk el dokuma halısı, ipek ve yün karışımı, 2x3 metre.',
        price: 15000.0,
        discountPrice: null,
        category: 'Ev Tekstili',
        brand: 'Hereke',
        images: [
          'https://example.com/images/hali1.jpg',
          'https://example.com/images/hali2.jpg',
        ],
        stock: 10,
        rating: 4.9,
        reviewCount: 32,
        isFeatured: true,
        isNewArrival: false,
        isBestSeller: false,
        origin: 'Türkiye',
        minimumOrderQuantity: '1 adet',
        shippingInfo: 'Özel kargo ile 7-10 iş günü',
        specifications: {
          'Malzeme': 'İpek ve yün karışımı',
          'Boyut': '2x3 metre',
          'Düğüm Sayısı': '1.000.000 düğüm/m²',
          'Menşei': 'Kocaeli, Türkiye',
        },
      ),
      Product(
        id: 3,
        name: 'Türk Çay Seti - Porselen',
        description:
            'Geleneksel Türk çay seti, 6 kişilik, altın yaldızlı porselen.',
        price: 850.0,
        discountPrice: 699.0,
        category: 'Mutfak',
        brand: 'Kütahya Porselen',
        images: [
          'https://example.com/images/cayset1.jpg',
          'https://example.com/images/cayset2.jpg',
        ],
        stock: 50,
        rating: 4.7,
        reviewCount: 128,
        isFeatured: false,
        isNewArrival: true,
        isBestSeller: true,
        origin: 'Türkiye',
        minimumOrderQuantity: '5 set',
        shippingInfo: '3-5 iş günü içinde kargo',
        specifications: {
          'İçerik': '6 çay bardağı, 6 tabak, 1 demlik, 1 çaydanlık',
          'Malzeme': 'Porselen',
          'Bulaşık Makinesi': 'Uyumlu değil',
          'Menşei': 'Kütahya, Türkiye',
        },
      ),
      Product(
        id: 4,
        name: 'Zeytinyağı - Soğuk Sıkım',
        description:
            'Erken hasat, soğuk sıkım sızma zeytinyağı. 5 litre teneke kutu.',
        price: 450.0,
        discountPrice: null,
        category: 'Gıda',
        brand: 'Tariş',
        images: [
          'https://example.com/images/zeytinyagi1.jpg',
          'https://example.com/images/zeytinyagi2.jpg',
        ],
        stock: 80,
        rating: 4.9,
        reviewCount: 312,
        isFeatured: true,
        isNewArrival: false,
        isBestSeller: true,
        origin: 'Türkiye',
        minimumOrderQuantity: '10 kutu',
        shippingInfo: '3-5 iş günü içinde kargo',
        specifications: {
          'Asit Oranı': '%0.3',
          'Hasat': 'Erken hasat',
          'İşleme': 'Soğuk sıkım',
          'Menşei': 'Ayvalık, Türkiye',
        },
      ),
      Product(
        id: 5,
        name: 'Bakır Cezve Seti',
        description: 'El işçiliği bakır cezve seti, 4 farklı boy cezve içerir.',
        price: 320.0,
        discountPrice: 280.0,
        category: 'Mutfak',
        brand: 'Gaziantep Bakırcılar',
        images: [
          'https://example.com/images/cezve1.jpg',
          'https://example.com/images/cezve2.jpg',
        ],
        stock: 35,
        rating: 4.6,
        reviewCount: 87,
        isFeatured: false,
        isNewArrival: true,
        isBestSeller: false,
        origin: 'Türkiye',
        minimumOrderQuantity: '3 set',
        shippingInfo: '3-5 iş günü içinde kargo',
        specifications: {
          'Malzeme': 'Saf bakır',
          'İçerik': '4 farklı boy cezve',
          'Bakım': 'Düzenli kalaylama gerektirir',
          'Menşei': 'Gaziantep, Türkiye',
        },
      ),
    ];
  }
}
