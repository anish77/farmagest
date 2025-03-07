import 'package:farmagest/data/constants.dart';
import 'package:flutter/material.dart';

class SwitchRow extends StatefulWidget {
  const SwitchRow({super.key, required this.titlo});

  final String titlo;
  @override
  State<SwitchRow> createState() => _SwitchRowState();
}

class _SwitchRowState extends State<SwitchRow> {
  bool isFarmParaf = false; // Stato iniziale dello switch
  bool isAttivi = false; // Stato iniziale dello switch
  bool isSoloTorino = false; // Stato iniziale dello switch

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.titlo,
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(color: kAmberRed),
        ),
        Spacer(),
        Switch(
          value: isFarmParaf,
          onChanged: (value) {
            setState(() {
              isFarmParaf = value; // Cambia lo stato dello switch
            });
          },
          activeColor: Colors.green, // Colore della pallina quando è attivo
          inactiveThumbColor:
              Colors.white, // Colore della pallina quando è disattivo
          inactiveTrackColor:
              kAmberRed2, // Colore della traccia quando è disattivo
          /*activeTrackColor:
              Colors.yellow,*/
          // Colore della traccia quando è attivo
          // activeTrackColor: Colors.yellow,
        ),
      ],
    );
  }
}
