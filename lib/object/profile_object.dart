class ProfileObject{
  String email;
   String name;
  String phone;
  String point;
  ProfileObject(this.email, this.name, this.phone, this.point);

  ProfileObject.fromJson(Map<String, dynamic> json)
  :email=json['email'],
  name=json['name'],
  phone=json['phone'],
  point=json['point'];

   Map<String, Object?> toJson() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'point':point
    };
  }
}