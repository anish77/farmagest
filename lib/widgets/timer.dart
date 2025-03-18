import 'dart:async';
import 'package:farmagest/data/constants.dart';
import 'package:farmagest/provider/tcp_connection.dart';
import 'package:farmagest/screens/login_page.dart';
import 'package:flutter/material.dart';

class TimerWidget {
  Timer? inactivityTimer;
  final int _timeoutDuration = 500; // Timeout di 500 secondi

  // Resetta il timer di inattività
  void resetInactivityTimer(
    BuildContext context,
    TcpConnectionNotifier tcpConnection,
  ) {
    // Annulla il timer esistente
    inactivityTimer?.cancel();

    // Crea un nuovo timer che scade dopo il tempo di inattività
    inactivityTimer = Timer(
      Duration(seconds: _timeoutDuration),
      () => _logout(context, tcpConnection),
    );
  }

  // Funzione chiamata quando l'utente interagisce con l'app
  void onUserInteraction(
    BuildContext context,
    TcpConnectionNotifier tcpConnection,
  ) {
    resetInactivityTimer(
      context,
      tcpConnection,
    ); // Reset del timer ogni volta che c'è interazione
  }

  void _logout(BuildContext context, TcpConnectionNotifier tcpConnection) {
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(kComunicInterrotta),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  tcpConnection.sendMessage(kLogOut);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (ctx) => const LoginPage()),
                  );
                },
                child: Text('Ok'),
              ),
            ],
          ),
    );
  }
}
