class User {
  final String email;
  final String name;
  final String id;
  final String? userProfile;

  User({
    required this.email,
    required this.name,
    required this.id,
    this.userProfile,
  });
}
