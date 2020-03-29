import 'package:flutter/material.dart';

Future<bool> alertConfirmCancel(BuildContext context, String title, String content) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          FlatButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      );
    },
  );
}

Function showSnackBar(String text, GlobalKey<ScaffoldState> scaffoldKey){
  scaffoldKey.currentState.showSnackBar(new SnackBar(
    content: new Text(text),
  ));
}