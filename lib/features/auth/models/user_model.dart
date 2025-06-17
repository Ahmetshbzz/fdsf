class User {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? companyName;
  final String? taxId;
  final String? address;
  final String? city;
  final String? country;
  final String? profileImage;
  final bool isVerified;
  final String role; // admin, seller, buyer
  final DateTime createdAt;
  final DateTime? lastLoginAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.companyName,
    this.taxId,
    this.address,
    this.city,
    this.country,
    this.profileImage,
    required this.isVerified,
    required this.role,
    required this.createdAt,
    this.lastLoginAt,
  });

  // JSON'dan model oluşturma
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      companyName: json['company_name'],
      taxId: json['tax_id'],
      address: json['address'],
      city: json['city'],
      country: json['country'],
      profileImage: json['profile_image'],
      isVerified: json['is_verified'] ?? false,
      role: json['role'] ?? 'buyer',
      createdAt: DateTime.parse(json['created_at']),
      lastLoginAt: json['last_login_at'] != null
          ? DateTime.parse(json['last_login_at'])
          : null,
    );
  }

  // Model'den JSON oluşturma
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'company_name': companyName,
      'tax_id': taxId,
      'address': address,
      'city': city,
      'country': country,
      'profile_image': profileImage,
      'is_verified': isVerified,
      'role': role,
      'created_at': createdAt.toIso8601String(),
      'last_login_at': lastLoginAt?.toIso8601String(),
    };
  }

  // Kullanıcının admin olup olmadığını kontrol etme
  bool get isAdmin => role == 'admin';

  // Kullanıcının satıcı olup olmadığını kontrol etme
  bool get isSeller => role == 'seller';

  // Kullanıcının alıcı olup olmadığını kontrol etme
  bool get isBuyer => role == 'buyer';

  // Kullanıcı bilgilerini güncelleme
  User copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? companyName,
    String? taxId,
    String? address,
    String? city,
    String? country,
    String? profileImage,
    bool? isVerified,
    String? role,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      companyName: companyName ?? this.companyName,
      taxId: taxId ?? this.taxId,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      profileImage: profileImage ?? this.profileImage,
      isVerified: isVerified ?? this.isVerified,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }
}
