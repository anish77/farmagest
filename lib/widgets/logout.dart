import 'package:flutter/material.dart';

class Logout {
  void logOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Conferma Logout'),
          content: Text('Vuoi davvero fare il logout?'),
          actions: [
            TextButton(
              onPressed: () {
                //Navigator.pop(context);
                // Ritorna al tab precedente
                // _onTabSelected(indexPrecedente);
              },
              child: Text('Annulla'),
            ),
            TextButton(onPressed: () {}, child: Text('Logout')),
          ],
        );
      },
    );
  }
}
