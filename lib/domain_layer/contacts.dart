class Contact {
  int? id;
  String name;
  String phone;
  String email;
  bool isFavorite;

  Contact({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      isFavorite: map['isFavorite'] == 1,
    );
  }
}
