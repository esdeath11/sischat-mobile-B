import 'package:flutter/material.dart';


showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () => Navigator.pop(context),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Warning !!!"),
    content: Text("Data tidak lengkap"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogAccess(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () => Navigator.pop(context),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Selamat!!!"),
    content: Text("Anda Terdaftar di sischat - B"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}