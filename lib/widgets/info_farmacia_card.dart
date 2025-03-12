import 'package:farmagest/data/constants.dart';
import 'package:flutter/material.dart';

class InfoFarmaciaCard extends StatelessWidget {
  const InfoFarmaciaCard({
    super.key,
    required this.nome,
    required this.secNome,
    required this.codice,
    required this.indirizzo,
    required this.cap,
    required this.pIva,
    required this.telefono,
    required this.cell,
    required this.farmAttiva,
    required this.index,
  });

  final String nome;
  final String secNome;
  final String codice;
  final String indirizzo;
  final String cap;
  final String pIva;
  final String telefono;
  final String cell;
  final String farmAttiva;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // todo det. farmacia
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        color: kLightBrown,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$nome ($codice)',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: kAmberRed),
              ),
              SizedBox(height: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(secNome),
                  Text(indirizzo),
                  Text(cap),
                  Text('p.iva $pIva'),
                  Text('$telefono   $cell'),
                  Text(farmAttiva),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
