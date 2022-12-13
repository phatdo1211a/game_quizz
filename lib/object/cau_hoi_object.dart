class CauHoiObject {
  final int id;
  final String cauHoi;
  final String dap_an_dung;
  final String dap_an_1;
  final String dap_an_2;
  final String dap_an_3;
  final String dap_an_4;
  final int id_chu_de;

  CauHoiObject(this.id, this.cauHoi, this.dap_an_dung, this.dap_an_1,
      this.dap_an_2, this.dap_an_3, this.dap_an_4, this.id_chu_de);

  CauHoiObject.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        cauHoi = json['cau_hoi'],
        dap_an_dung = json['dap_an_dung'],
        dap_an_1 = json['dap_an_1'],
        dap_an_2 = json['dap_an_2'],
        dap_an_3 = json['dap_an_3'],
        dap_an_4 = json['dap_an_4'],
        id_chu_de = json['id_chu_de'];

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'cau_hoi': cauHoi,
      'dap_an_dung': dap_an_dung,
      'dap_an_1': dap_an_1,
      'dap_an_2': dap_an_2,
      'dap_an_3': dap_an_3,
      'dap_an_4': dap_an_4,
      'id_chu_de': id_chu_de,
    };
  }
}
