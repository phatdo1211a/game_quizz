class ProfileObject {
  String email;
  String name;
  String phone;
  ProfileObject(this.email, this.name, this.phone);

  ProfileObject.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        name = json['name'],
        phone = json['phone'];

  Map<String, Object?> toJson() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
    };
  }
}
