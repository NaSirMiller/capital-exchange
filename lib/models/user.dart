class AppUser {

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json["uid"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      role: json["role"],
      profileLogoFilepath: json["profile_logo_filepath"] as String?,
    );
  }

  AppUser({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    this.profileLogoFilepath,
  });
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String? profileLogoFilepath;

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "role": role,
      "profile_logo_filepath": profileLogoFilepath,
    };
  }
}
