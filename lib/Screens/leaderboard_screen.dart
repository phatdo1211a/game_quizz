import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../play/components/box_leader_board.dart';

class   LeaderboardScreen extends ConsumerStatefulWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen> {
  @override
  void initState() {
    super.initState();
    // DatabaseReference leaderboardRef =
    //     FirebaseDatabase.instance.ref('leaderboard');

    // leaderboardRef.onValue.listen((DatabaseEvent event) async {
    //   await ref.read(leaderboardProvider.notifier).fetchLeaderboard();
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
 
  Widget build(BuildContext context) {
    final String src3 =
        'https://khoinguonsangtao.vn/wp-content/uploads/2022/07/avatar-cute-2-560x560.jpg';
    final String src2 =
        'https://khoinguonsangtao.vn/wp-content/uploads/2022/07/avatar-cute-2-560x560.jpg';
    final String src1 =
        'https://khoinguonsangtao.vn/wp-content/uploads/2022/07/avatar-cute-2-560x560.jpg';
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: const Color(0xff1F1147),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                  const SizedBox(width: 10),
                  const Text(
                    'Bảng xếp hạng',
                    style: TextStyle(fontSize: 23, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(5, 40, 5, 20),
                    color: const Color(0xff1F1147),
                    child: Row(
                      children: [
                        BoxLeaderBoard(
                          rank: 2,
                          image: Image(image: NetworkImage(src1)),
                          name: 'nguyen van dang khoa',
                          points: 10000,
                          padding: 0,
                        ),
                        BoxLeaderBoard(
                          rank: 1,
                          image: Image(image: NetworkImage(src2)),
                          name: 'nguyen van nho',
                          points: 5000,
                          padding: 60,
                        ),
                        BoxLeaderBoard(
                          rank: 3,
                          image: Image(image: NetworkImage(src3)),
                          name: 'do tan phat',
                          points: 2500,
                          padding: 0,
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      int newIndex = index + 3;
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  color: Color.fromARGB(54, 0, 0, 0)),
                            ]),
                        child: Row(
                          children: [
                            Text(
                              '#${newIndex + 1}',
                              style: const TextStyle(
                                color: Color(0xff6948FE),
                                fontSize: 23,
                              ),
                            ),
                            const SizedBox(width: 10),
                            ClipOval(
                              child: Image.network(
                                src1,
                                width: 50,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                'nguyen van nho',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xff1F1147),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Image.asset(
                              'assets/award3.png',
                              width: 40,
                            ),
                            Text(
                              '100000',
                              style: const TextStyle(
                                color: Color(0xff1F1147),
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              // error: (e, st) => Text(e.toString()),
              // loading: () =>
              //     const Center(child: CircularProgressIndicator())
            ),
          ],
        ),
      ),
    );
  }
}
