//the alert
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert customAlert({
  required String title,
  required String desc,
  required String text,
  required Function() onPressed,
  required BuildContext context,
}) {
  return Alert(
      context: context,
      title: title,
      desc: desc,
      style: AlertStyle(
        isCloseButton: false,
        isOverlayTapDismiss: false,
      ),
      buttons: [
        DialogButton(
          color: Color.fromARGB(255, 1, 92, 4),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ]);
}
