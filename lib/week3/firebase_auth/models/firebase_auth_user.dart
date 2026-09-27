class FirebaseAuthUser {
  final String uid;
  final String email;
  final String displayName;
  final bool isEmailVerified;
  final DateTime createdAt;

  FirebaseAuthUser({
    required this.uid,
    required this.email,
    required this.displayName,
    this.isEmailVerified = true,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
