class User {
  final String id;
  final String type;
  final String name;
  final String photo;
  final String cpf;
  final String dateBirth;
  final String city;
  final String phone;
  final String email;
  final String password;
  
  const User({
    required this.id,
    required this.type,
    required this.name,
    required this.photo,
    required this.cpf,
    required this.dateBirth,
    required this.city,
    required this.phone,
    required this.email,
    required this.password,
  });

  User copyWith({
    String? id,
    String? type,
    String? name,
    String? photo,
    String? cpf,
    String? dateBirth,
    String? city,
    String? phone,
    String? email,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      cpf: cpf ?? this.cpf,
      dateBirth: dateBirth ?? this.dateBirth,
      city: city ?? this.city,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  factory User.fromMap(Map<String, dynamic> map, String id) {
    return User(
      id: id,
      type: map['type'] ?? '',
      name: map['name'] ?? '',
      photo: map['photo'] ?? '',
      cpf: map['cpf'] ?? '',
      dateBirth: map['dateBirth'] ?? '',
      city: map['city'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

// método para criar um User a partir de um documento Firestore
  factory User.fromDocumentSnapshot(Map<String, dynamic> doc, String id) {
    return User(
      id: id,
      type: doc['type'] ?? '',
      name: doc['name'] ?? '',
      photo: doc['photo'] ?? '',
      cpf: doc['cpf'] ?? '',
      dateBirth: doc['dateBirth'] ?? '',
      city: doc['city'] ?? '',
      phone: doc['phone'] ?? '',
      email: doc['email'] ?? '',
      password: doc['password'] ?? '',
    );
  }

  // método para converter um User para um mapa para salvar no Firestore
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'name': name,
      'photo': photo,
      'cpf': cpf,
      'dateBirth': dateBirth,
      'city': city,
      'phone': phone,
      'email': email,
      'password': password,
    };
  }
}