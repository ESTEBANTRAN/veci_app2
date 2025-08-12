class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatarUrl;
  final String? address;
  final String? country;
  final String? state;
  final String? city;
  final String? citadel;
  final String? houseNumber;
  final String? zip;
  final DateTime? birthDate;
  final String? role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatarUrl,
    this.address,
    this.country,
    this.state,
    this.city,
    this.citadel,
    this.houseNumber,
    this.zip,
    this.birthDate,
    this.role,
  });

  // Factory constructor para crear un UserModel desde un mapa (por ejemplo, de Firebase o una API)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'],
      avatarUrl: map['avatarUrl'],
      address: map['address'],
      country: map['country'],
      state: map['state'],
      city: map['city'],
      citadel: map['citadel'],
      houseNumber: map['houseNumber'],
      zip: map['zip'],
      birthDate: map['birthDate'] != null
          ? DateTime.tryParse(map['birthDate'])
          : null,
      role: map['role'],
    );
  }

  // Método para convertir el UserModel a un mapa (útil para guardar en base de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatarUrl': avatarUrl,
      'address': address,
      'country': country,
      'state': state,
      'city': city,
      'citadel': citadel,
      'houseNumber': houseNumber,
      'zip': zip,
      'birthDate': birthDate?.toIso8601String(),
      'role': role,
    };
  }
}
