import 'package:farmagest/data/constants.dart';
import 'package:farmagest/screens/agenda_page.dart';
import 'package:farmagest/screens/clienti_page.dart';
import 'package:farmagest/widgets/logout.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({super.key});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  late int _currentIndex = 0;

  void _onTabSelected(int index) {
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
              TextButton(onPressed: () {}, child: Text('Logout')),
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
