import 'package:flutter/material.dart';

import 'package:game_quizz/play/views/questions_page.dart';
import 'package:game_quizz/screens/login.dart';
import 'package:game_quizz/screens/nextpage.dart';
import 'package:google_fonts/google_fonts.dart';

Container customStartButton({required BuildContext context}) {
  return Container(
    child: Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 15),
      child: TextButton(
        onPressed: () {
          nextpage(context, LoginApp());
        },
        child: Container(
          width: 250,
          height: 60,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/answer_box.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                'Bắt đầu',
                style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
