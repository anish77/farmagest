import 'package:farmagest/data/constants.dart';
import 'package:farmagest/models/info_pers.dart';
import 'package:flutter/material.dart';

class AgendaDetailPage extends StatelessWidget {
  const AgendaDetailPage({
    super.key,
    required this.data,
    required this.agendaDati,
  });

  final String data;
  final List<dynamic> agendaDati;

  List<dynamic> stringToList(List<dynamic> agendaDati) {
    List<dynamic> agendaDatiFinali = [];
    InfoPers infoPers;

    agendaDati.forEach((item) {
      String oggetto = findValue(item, "OGGETTO");
      String operatore = findValue(item, "OPERATORE");
      String campo02 = findValue(item, "CAMPO02");

      infoPers = InfoPers(
        oggetto: oggetto,
        operatore: operatore,
        campo02: campo02,
      );
      agendaDatiFinali.add(infoPers);
      //print("OGGETTO: $oggetto | OPERATORE: $operatore | CAMPO02: $campo02");*/
    });

    return agendaDatiFinali;
  }

  // Funzione per trovare un valore dato un campo
  String findValue(List<dynamic> item, String key) {
    return item
        .firstWhere(
          (field) => field[0] == key,
          orElse:
              () => [
                "",
                "",
              ], // Se non trova il valore, ritorna una coppia vuota
        )[1]
        .toString()
        .trim(); // Rimuove spazi extra
  }

  @override
  Widget build(BuildContext context) {
    var agendaDatiList = [];
    agendaDatiList = stringToList(agendaDati);
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );

    if (agendaDatiList.isNotEmpty) {
      content = ListView.builder(
        itemCount: agendaDatiList.length,
        itemBuilder: (ctx, index) {
          final info = agendaDatiList[index];
          return Card(
            margin: const EdgeInsets.all(8),
            color: kLightBrown,

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(child: Text('${info.campo02} ')),
                      Flexible(child: Text(info.operatore.toString())),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          info.oggetto,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agenda $data',
          style: TextStyle(
            color: kAmberRed,
            fontSize: 25,
            fontWeight: FontWeight.normal,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // todo
            // Qui puoi aggiungere logica personalizzata prima di tornare indietro
            // Navigator.pop(context);
            Navigator.of(context).pop();
            //Navigator.popUntil(context, ModalRoute.withName(AgendaPage()));
          },
        ),
      ),
      backgroundColor: kLightBrown2,
      body: content,
    );
  }
}
