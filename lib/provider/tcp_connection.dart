import 'dart:async';

import 'package:farmagest/data/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:tcp_socket_connection/tcp_socket_connection.dart';

class TcpConnectionNotifier extends StateNotifier<String?> {
  TcpConnectionNotifier() : super('');

  final StreamController<String> _controller =
      StreamController<String>.broadcast();
  Stream<String> get responseStream => _controller.stream;
  TcpSocketConnection socketConnection = TcpSocketConnection(kIp, kPort);

  var logger = Logger(printer: PrettyPrinter());

  void loginRequest() {
    logger.f('loginRequest');
    connectAndSendMessage(kIp, kLogin, socketConnection);
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

  void logOut(String messaggio) {
    if (socketConnection.isConnected() && messaggio.isNotEmpty) {
      socketConnection.sendMessage(messaggio);
    }
  }
}

final dnsConnectionProvider =
    StateNotifierProvider<TcpConnectionNotifier, String?>(
      (ref) => TcpConnectionNotifier(),
    );
