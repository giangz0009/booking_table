class AppUser {
  final String id;
  final String? email;
  final String name;
  final String role; // admin | staff | waiter ...
  final String? avatarUrl;

  AppUser({
    required this.id,
    required this.name,
    required this.role,
    this.email,
    this.avatarUrl,
  });

  factory AppUser.fromMap(Map<String, dynamic> map, String id) {
    return AppUser(
      id: id,
      name: (map['name'] ?? '') as String,
      role: (map['role'] ?? 'staff') as String,
      email: map['email'] as String?,
      avatarUrl: map['avatarUrl'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'role': role,
    'email': email,
    'avatarUrl': avatarUrl,
  };

  AppUser copyWith({String? name, String? role, String? avatarUrl}) {
    return AppUser(
      id: id,
      name: name ?? this.name,
      role: role ?? this.role,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
