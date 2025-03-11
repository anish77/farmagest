import 'dart:async';

import 'package:farmagest/data/constants.dart';
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
    connectAndSendMessage(kIp, kLogin, tcpSocket);
  }

  Future<void> retrieveDaySchedule() async {
    final response = await _controller.stream.first;
    //final response2 = await _controller.stream.last;
    print("******************* $response");

    //final isDone = await _controller.done;
    // print("1111111111111  $response2");
    print("1111111111111  22222");
    //return isDone;
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
