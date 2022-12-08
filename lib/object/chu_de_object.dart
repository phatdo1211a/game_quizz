class ChuDeObject {
  final int id;
  final String chude;
  final String image;

  ChuDeObject(
    this.id,
    this.chude,
    this.image,
  );

  ChuDeObject.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        chude = json['chude'],
         image = json['image'];

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'chude': chude,
      'image':image,
    };
  }
}
