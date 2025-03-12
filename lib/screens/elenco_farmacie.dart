import 'package:farmagest/data/constants.dart';
import 'package:farmagest/models/info_pers.dart';
import 'package:farmagest/widgets/info_farmacia_card.dart';
import 'package:flutter/material.dart';

class ElencoFarmacie extends StatelessWidget {
  const ElencoFarmacie({super.key, required this.farmaciaDati});

  final List<dynamic> farmaciaDati;

  List<dynamic> stringToList(List<dynamic> farmaciaDati) {
    List<dynamic> farmaciaList = [];
    InfoFarmacia infoFarmacia;

    farmaciaDati.forEach((item) {
      String nome = findValue(item, "D2");
      String secNome = findValue(item, "N2");
      String codice = findValue(item, "D1");
      String indirizzo = findValue(item, "N3");
      String cap = findValue(item, "N4");
      String pIva = findValue(item, "N5");
      String telefono = findValue(item, "N11");
      String cell = findValue(item, "N13");
      String farmAttiva = findValue(item, "INFOEXTRA");

      infoFarmacia = InfoFarmacia(
        nome: nome,
        secNome: secNome,
        codice: codice,
        indirizzo: indirizzo,
        cap: cap,
        pIva: pIva,
        telefono: telefono,
        cell: cell,
        farmAttiva: farmAttiva,
      );
      farmaciaList.add(infoFarmacia);
    });

    return farmaciaList;
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
    var farmacieDatiList = [];
    farmacieDatiList = stringToList(farmaciaDati);
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

    if (farmacieDatiList.isNotEmpty) {
      content = ListView.builder(
        itemCount: farmacieDatiList.length,
        itemBuilder: (ctx, index) {
          final info = farmacieDatiList[index];
          return InfoFarmaciaCard(
            nome: info.nome,
            secNome: info.secNome,
            codice: info.codice,
            indirizzo: info.indirizzo,
            cap: info.cap,
            pIva: info.pIva,
            telefono: info.telefono,
            cell: info.cell,
            farmAttiva: info.farmAttiva,
            index: index,
          );
        },
        // InfoFarmaciaCard(infoFarmacia: farmacieDatiList, index: index),
      );
    }

    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        backgroundColor: kLightBrown2,
        appBar: AppBar(title: Text("Clienti")),
        body: content,
      ),
    );
  }
}
