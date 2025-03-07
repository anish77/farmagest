import 'package:farmagest/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AgendaPage> {
  @override
  // Crea un controller per il calendario
  late final ValueNotifier<DateTime> _selectedDay;
  late final ValueNotifier<DateTime> _focusedDay;

  @override
  void initState() {
    super.initState();
    // Inizializza il valore del giorno selezionato
    _selectedDay = ValueNotifier(DateTime.now());
    _focusedDay = ValueNotifier(DateTime.now());
  }

  @override
  void dispose() {
    _selectedDay.dispose();
    _focusedDay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Calendario Flutter')),
      backgroundColor: Color.fromARGB(255, 247, 230, 198),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Usa TableCalendar per visualizzare il calendario
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2025, 12, 31),
              focusedDay: _focusedDay.value,
              selectedDayPredicate: (day) {
                // Restituisce se il giorno è selezionato
                return isSameDay(_selectedDay.value, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay.value = selectedDay;
                  _focusedDay.value = focusedDay;
                });
              },
              onPageChanged: (focusedDay) {
                // Cambia la data di focus quando si cambia la pagina
                _focusedDay.value = focusedDay;
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: () {}, //scanBarcode,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(kLightBrown),
                        side: WidgetStateProperty.all(
                          BorderSide(color: kAmberRed, width: 2.0),
                        ),
                      ),
                      child: Text(
                        'Cerca',
                        style: (TextStyle(color: kAmberRed)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Visualizza il giorno selezionato
            /* Text(
              'Giorno selezionato: ${_selectedDay.value.toLocal()}',
              style: TextStyle(fontSize: 16),
            ),*/
          ],
        ),
      ),
    );
  }
}
