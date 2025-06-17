import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

// Ürün servisi sağlayıcısı
final productServiceProvider = Provider<ProductService>((ref) {
  return ProductService();
});

// Tüm ürünler için sağlayıcı
final productsProvider = FutureProvider<List<Product>>((ref) async {
  final productService = ref.watch(productServiceProvider);
  return await productService.getProducts();
});

// Öne çıkan ürünler için sağlayıcı
final featuredProductsProvider = FutureProvider<List<Product>>((ref) async {
  final productService = ref.watch(productServiceProvider);
  return await productService.getFeaturedProducts();
});

// Yeni gelen ürünler için sağlayıcı
final newArrivalsProvider = FutureProvider<List<Product>>((ref) async {
  final productService = ref.watch(productServiceProvider);
  return await productService.getNewArrivals();
});

// Çok satanlar için sağlayıcı
final bestSellersProvider = FutureProvider<List<Product>>((ref) async {
  final productService = ref.watch(productServiceProvider);
  return await productService.getBestSellers();
});

// Kategori bazlı ürünler için sağlayıcı
final productsByCategoryProvider =
    FutureProvider.family<List<Product>, String>((ref, category) async {
  final productService = ref.watch(productServiceProvider);
  return await productService.getProductsByCategory(category);
});

// Tek bir ürün için sağlayıcı
final productProvider = FutureProvider.family<Product, int>((ref, id) async {
  final productService = ref.watch(productServiceProvider);
  return await productService.getProductById(id);
});

// Ürün arama sağlayıcısı
final searchProductsProvider =
    FutureProvider.family<List<Product>, String>((ref, query) async {
  final productService = ref.watch(productServiceProvider);
  return await productService.searchProducts(query);
});

// Ürün filtreleme sağlayıcısı
final filterProductsProvider =
    FutureProvider.family<List<Product>, Map<String, dynamic>>(
        (ref, filters) async {
  final productService = ref.watch(productServiceProvider);
  return await productService.filterProducts(filters);
});
