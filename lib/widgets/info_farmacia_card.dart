import 'package:farmagest/data/constants.dart';
import 'package:farmagest/screens/dettaglio_farmacia.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void _showNumberDialog(BuildContext context) {
    // print(cell);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.phone),
                title: Text(telefono),
                onTap: () => _callNumber(telefono),
              ),
              if (cell.isNotEmpty)
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(cell),
                  onTap: () => _callNumber(cell),
                ),
            ],
          ),
        );
      },
    );
  }

  void _callNumber(String number) async {
    final Uri url = Uri.parse('tel:$number');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('Errore: impossibile aprire il numero');
    }
  }

  void openGoogleMaps(String destination) async {
    final Uri url = Uri.parse(
      "https://www.google.com/maps/dir/?api=1&origin=My+Location&destination=${Uri.encodeComponent(destination)}",
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Impossibile aprire Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (ctx) => DettaglioFarmacia(
                  nome: nome,
                  userId: "userId",
                  password: "password",
                  host: "host",
                  pwdAdmin: "pwdAdmin",
                  altroAccount: "altroAccount",
                  ultimoAgg: "ultimoAgg",
                  dataUltimoC: "dataUltimoC",
                  oraUltimoC: "oraUltimoC",
                  versione: "versione",
                  server: "server",
                ),
          ),
        );
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
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          openGoogleMaps('$indirizzo $cap');
                        },
                        child: Image.asset(
                          'assets/images/maps.png',
                          width: 50,
                          height: 50,
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          _showNumberDialog(context);
                        },

                        child: Icon(Icons.phone, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Colore del bottone
                          shape: CircleBorder(), // Per renderlo rotondo
                          padding: EdgeInsets.all(15), // Padding interno
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
