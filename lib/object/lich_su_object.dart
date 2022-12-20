class LichSuObject {
  final String tenNguoiChoi;
  final String ngayChoi;
  final int? soCauDung;
  final int? soCauSai;
  final int? tongDiem;

  LichSuObject(
    this.tenNguoiChoi,
    this.ngayChoi,
    this.soCauDung,
    this.soCauSai,
    this.tongDiem,
  );

  LichSuObject.fromJson(Map<String, dynamic> json)
      : tenNguoiChoi = json['tenNguoiChoi'],
        ngayChoi = json['ngayChoi'],
        soCauDung = json['soCauDung'],
        soCauSai = json['soCauSai'],
        tongDiem = json['tongDiem'];

  Map<String, Object?> toJson() => {
        'tenNguoiChoi': tenNguoiChoi,
        'ngayChoi': ngayChoi,
        'soCauDung': soCauDung,
        'soCauSai': soCauSai,
        'tongDiem': tongDiem,
      };
}
