import 'dart:async';

import 'package:farmagest/data/constants.dart';
import 'package:farmagest/provider/tcp_connection.dart';
import 'package:farmagest/screens/agenda_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AgendaPage extends ConsumerStatefulWidget {
  const AgendaPage({super.key});

  @override
  ConsumerState<AgendaPage> createState() => AgendaPageState();
}

class AgendaPageState extends ConsumerState<AgendaPage> {
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

  Future<void> getDatiAgenda(
    TcpConnectionNotifier tcpConnection,
    String formattedDate,
  ) async {
    var responseBuffer = '';
    StreamSubscription? subscription;

    subscription = tcpConnection.responseStream.listen((response) {
      responseBuffer += response;

      if (responseBuffer.contains(']]]')) {
        subscription?.cancel();

        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (ctx) => AgendaDetailPage(
                    data: formattedDate,
                    agendaDati: responseBuffer,
                  ),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tcpConnection = ref.read(dnsConnectionProvider.notifier);
    DateTime dateTime = DateTime.parse(_selectedDay.value.toString());
    String formattedDate = DateFormat("dd/MM/yy").format(dateTime);

    return Scaffold(
      //appBar: AppBar(title: Text('Calendario Flutter')),
      backgroundColor: kLightBrown2,
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
                      onPressed: () {
                        final ricerca = '$kRiceAgenda [["$formattedDate"]]';
                        tcpConnection.sendMessage(ricerca);
                        tcpConnection.retrieveDaySchedule();

                        //getDatiAgenda(tcpConnection, formattedDate);
                      },
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
          ],
        ),
      ),
    );
  }
}
