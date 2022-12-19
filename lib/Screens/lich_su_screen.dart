import 'package:flutter/material.dart';
import 'package:game_quizz/object/chu_de_object.dart';
import 'package:game_quizz/object/lich_su_object.dart';
import 'package:game_quizz/play/components/custome_alert.dart';
import 'package:game_quizz/provider/chu_de_provider.dart';
import 'package:game_quizz/provider/lich_su_provider.dart';

class LichSuScreen extends StatefulWidget {
  const LichSuScreen({super.key});

  @override
  State<LichSuScreen> createState() => _LichSuScreenState();
}

class _LichSuScreenState extends State<LichSuScreen> {
  @override
  List<LichSuObject> lsLichSu = [];
  List<ChuDeObject> chuDe = [];
  Future<void> _loadLS() async {
    final data = await LichSuProvider.getDataById();
    setState(() {});
    lsLichSu = data;
  }

  Future<void> loadChuDe() async {
    final data = await ChuDeProvider.getDataById();
    setState(() {});
    chuDe = data;
  }

  @override
  void initState() {
    _loadLS();
    loadChuDe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 28, 100, 0),
          title: const Align(
            child: Text('Lịch sử chơi'),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: ListView.builder(
            itemCount: lsLichSu.length, //lsLichSu.length,
            itemBuilder: (context, index) {
              return Card(
              elevation: 25,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        color: Color.fromARGB(255, 1, 206, 86), width: 2),
                    borderRadius: BorderRadius.circular(30)),
                leading: Image.asset('assets/image.png'),
                title: Text(lsLichSu[index].tenNguoiChoi,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                subtitle: Text(lsLichSu[index].ngayChoi.toString()),
                trailing: Text(
                  chuDe[index].chude.toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  setState(() {
                    customAlert(
                      title:
                          'Số câu đúng ${lsLichSu[index].soCauDung}\nSố câu sai ${lsLichSu[index].soCauSai}',
                      desc: 'Tổng điểm: ${lsLichSu[index].tongDiem}',
                      text: 'Okay',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      context: context,
                    ).show();
                  });
                },
              ),
            );
            } 
          ),
        ),
      );
}
