import 'package:flutter/material.dart';
import 'package:game_quizz/screens/login.dart';
import 'package:game_quizz/screens/widgets.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image(context),
              _header(context),
              _input(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }
}

_image(context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Image.asset(
        "assets/image.png",
        width: 100,
        height: 100,
      ),
    ],
  );
}

_header(context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      text_quizz(context),
    ],
  );
}

_input(context) {
  const edgeInsets = EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0);
  return Container(
    padding: edgeInsets,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.mail),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Số điện thoại",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.phone),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: "Tên đăng nhập",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.person),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Mật khẩu",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.key),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Nhập lại mật khẩu",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.key),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {},
            child: Text(
              "Đăng kí",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
            ),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(200, 60),
              shape: StadiumBorder(),
              padding: edgeInsets,
            ))
      ],
    ),
  );
}

_signup(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Bạn đã có tài khoản?",
        style: TextStyle(color: Colors.black54, fontSize: 20),
      ),
      TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginApp()));
          },
          child: Text(
            "Đăng nhập ",
            style: TextStyle(fontSize: 20),
          ))
    ],
  );
}
