import 'package:flutter/material.dart';

class Alert {
  void showPopup(BuildContext context, String info) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Info'),
          content: Text(info),
          actions: <Widget>[
            TextButton(
              child: Text('Chiude'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup
              },
            ),
          ],
        );
      },
    );
  }
}
