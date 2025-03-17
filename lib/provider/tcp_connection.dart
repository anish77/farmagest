import 'dart:async';
import 'dart:convert';

import 'package:farmagest/data/constants.dart';
import 'package:farmagest/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:tcp_socket_connection/tcp_socket_connection.dart';

class TcpConnectionNotifier extends StateNotifier<String?> {
  TcpConnectionNotifier() : super('');

  final StreamController<String> _controller =
      StreamController<String>.broadcast();
  Stream<String> get responseStream => _controller.stream;
  TcpSocketConnection tcpSocket = TcpSocketConnection(kIp, kPort);

  var logger = Logger(printer: PrettyPrinter());

  void loginRequest() {
    final login = kLogin();
    connectAndSendMessage(kIp, login, tcpSocket);
  }

  Future<List<dynamic>> getFullResponseAsList() async {
    final Completer<List<dynamic>> completer = Completer<List<dynamic>>();
    String responseBuffer = '';

    StreamSubscription<dynamic>? subscription;
    subscription = responseStream.listen((chunk) {
      responseBuffer += chunk; // Accumula i dati ricevuti

      try {
        final decoded = jsonDecode(
          responseBuffer,
        ); // Prova a decodificare in una lista
        if (decoded is List) {
          // Verifica che sia effettivamente una lista
          subscription?.cancel(); // Se va bene, smetti di ascoltare

          completer.complete(decoded); // Completa il Future con la lista
        }
      } catch (e) {
        // Se il parsing fallisce, aspettiamo altri dati
        logger.e(e);
      }
    });

    return completer.future;
  }

  Future<String> getResponse(BuildContext context) async {
    String responseBuffer = '';

    StreamSubscription<dynamic>? subscription;
    subscription = responseStream.listen((chunk) {
      responseBuffer += chunk; // Accumula i dati ricevuti

      if (responseBuffer != '') {
        if (!context.mounted) return;
        Alert().showPopup(
          context,
          responseBuffer,
        ); // Evita di usare context se il widget è stato smontato
        responseBuffer = '';
        subscription?.cancel(); // smetti di ascoltare
      }
    });

    return responseBuffer;
  }

  //starting the connection and listening to the socket asynchronously
  Future<void> connectAndSendMessage(
    String cHostname,
    String msg,
    TcpSocketConnection tcpSocket,
  ) async {
    tcpSocket.enableConsolePrint(
      true,
    ); //use this to see in the console what's happening

    if (await tcpSocket.canConnect(5000, attempts: 3)) {
      //check if it's possible to connect to the endpoint

      logger.e(msg);
      await tcpSocket.connect(5000, messageReceived, attempts: 3);
      tcpSocket.sendMessage(msg);
    } else {
      logger.e(msg);
    }
  }

  Future<void> messageReceived(String msg) async {
    _controller.add(msg);
    if (msg.contains("login:")) {
      logger.i(msg);
    } else {
      logger.e("Errore Login");
      logger.e(msg);
    }
  }

  void sendMessage(String messaggio) {
    if (tcpSocket.isConnected() && messaggio.isNotEmpty) {
      tcpSocket.sendMessage(messaggio);
      logger.d(messaggio);
    }
  }
}

final dnsConnectionProvider =
    StateNotifierProvider<TcpConnectionNotifier, String?>(
      (ref) => TcpConnectionNotifier(),
    );
