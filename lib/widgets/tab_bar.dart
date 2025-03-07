import 'package:farmagest/data/constants.dart';
import 'package:farmagest/provider/tcp_connection.dart';
import 'package:farmagest/screens/agenda_page.dart';
import 'package:farmagest/screens/clienti_page.dart';
import 'package:farmagest/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabBarWidget extends ConsumerStatefulWidget {
  const TabBarWidget({super.key});

  @override
  ConsumerState<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends ConsumerState<TabBarWidget> {
  late int _currentIndex = 0;

  void _onTabSelected(int index) {
    final tcpConnection = ref.read(dnsConnectionProvider.notifier);
    int indexPrecedente = _currentIndex;
    setState(() {
      _currentIndex = index;
    });

    if (_currentIndex == 2) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Conferma Logout'),
            content: Text('Vuoi davvero fare il logout?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Ritorna al tab precedente
                  _onTabSelected(indexPrecedente);
                },
                child: Text('Annulla'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  tcpConnection.logOut(kLogOut);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (ctx) => const LoginPage()),
                  );
                },
                child: Text('Logout'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Center(child: ClientiPage()),
          Center(child: AgendaPage()),
          Center(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
        selectedItemColor: kAmberRed2,
        unselectedItemColor: Colors.grey, // Colore della scheda inattiva
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Clienti"),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Agenda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: "Scollega",
          ),
        ],
      ),
    );
  }
}
