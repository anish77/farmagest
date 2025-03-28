import 'package:farmagest/data/constants.dart';
import 'package:farmagest/widgets/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:farmagest/provider/tcp_connection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:tcp_socket_connection/tcp_socket_connection.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  var logger = Logger(printer: PrettyPrinter());

  bool isLoading = false;
  TcpSocketConnection socketConnection = TcpSocketConnection(kIp, kPort);

  @override
  void initState() {
    super.initState();
  }

  void showDialogIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Impedisce di chiudere cliccando fuori
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            //value: _controller.value,
          ),
        );
      },
    );
  }

  void login(TcpConnectionNotifier connection, BuildContext context) {
    if (isLoading) {
      showDialogIndicator(context);
    }

    try {
      connection.responseStream.listen((response) {
        if (response.contains('login: ')) {
          setState(() {
            isLoading = false;
            Navigator.pop(context);
          });
          if (isLoading == false) {
            if (!context.mounted) return;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (ctx) => const TabBarWidget()),
            );
          }
        }
      });
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tcpConnection = ref.read(dnsConnectionProvider.notifier);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 230, 198),
      body: Container(
        color: kLightBrown,
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: 100),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        20,
                      ), // Arrotondamento degli angoli
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover, // Adatta l'immagine al contenitore
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      kAppVer,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.copyWith(color: kAmberRed),
                    ),
                    SizedBox(height: 50),
                    Text(
                      kInfoLogin,
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge!.copyWith(color: kAmberRed),
                    ),
                    SizedBox(height: 100),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              height: 45,
                              child: customButton(tcpConnection, context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton customButton(
    TcpConnectionNotifier tcpConnection,
    BuildContext context,
  ) {
    return ElevatedButton(
      onPressed: () {
        isLoading = true;
        tcpConnection.loginRequest();
        login(tcpConnection, context);
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(kLightBrown),
        side: WidgetStateProperty.all(BorderSide(color: kAmberRed, width: 2.0)),
      ),
      child: Text('Accedi', style: (TextStyle(color: kAmberRed, fontSize: 20))),
    );
  }
}
