import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helpers {
  // Para birimi formatı
  static String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'tr_TR',
      symbol: '₺',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  // Tarih formatı
  static String formatDate(DateTime date) {
    final formatter = DateFormat('dd.MM.yyyy', 'tr_TR');
    return formatter.format(date);
  }

  // Zaman formatı
  static String formatTime(DateTime time) {
    final formatter = DateFormat('HH:mm', 'tr_TR');
    return formatter.format(time);
  }

  // Tarih ve zaman formatı
  static String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('dd.MM.yyyy HH:mm', 'tr_TR');
    return formatter.format(dateTime);
  }

  // SnackBar gösterme
  static void showSnackBar(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  // Yükleniyor dialog gösterme
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  // Dialog gösterme
  static Future<bool?> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Evet',
    String cancelText = 'Hayır',
  }) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              confirmText,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // İndirim hesaplama
  static double calculateDiscount(
      double originalPrice, double discountPercentage) {
    return originalPrice - (originalPrice * discountPercentage / 100);
  }

  // KDV hesaplama
  static double calculateVAT(double price, double vatRate) {
    return price * vatRate / 100;
  }
}
