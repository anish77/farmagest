import 'package:farmagest/data/constants.dart';
import 'package:flutter/material.dart';

class DettaglioFarmacia extends StatelessWidget {
  const DettaglioFarmacia({
    super.key,
    required this.nome,
    required this.userId,
    required this.password,
    required this.host,
    required this.pwdAdmin,
    required this.altroAccount,
    required this.ultimoAgg,
    required this.dataUltimoC,
    required this.oraUltimoC,
    required this.versione,
    required this.server,
  });

  final String nome;
  final String userId;
  final String password;
  final String host;
  final String pwdAdmin;
  final String altroAccount;
  final String ultimoAgg;
  final String dataUltimoC;
  final String oraUltimoC;
  final String versione;
  final String server;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightBrown2,
      appBar: AppBar(title: Text(nome)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 120, child: Text('agg. part.')),
                SizedBox(width: 200, child: TextField()), // Larghezza fissa
              ],
            ),
            Row(
              children: [
                SizedBox(width: 120, child: Text('userid')),
                Text(userId),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 120, child: Text('password')),
                Text(password),
              ],
            ),
            Row(
              children: [SizedBox(width: 120, child: Text('host')), Text(host)],
            ),
            Row(
              children: [
                SizedBox(width: 120, child: Text('pwd admin')),
                Text(pwdAdmin),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 120, child: Text('altro account')),
                Text(altroAccount),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 120, child: Text('ultimo agg.')),
                Text(ultimoAgg),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 120, child: Text('data ultimo c.')),
                Text(dataUltimoC),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 120, child: Text('ora ultimo c.')),
                Text(oraUltimoC),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 120, child: Text('versione')),
                Text(versione),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 120, child: Text('server')),
                Text(server),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/*
Row(children: [Text('agg. part.'), TextField()]),
          Row(children: [Text('userid'), Text(userId)]),
          Row(children: [Text('password'), Text(password)]),
          Row(children: [Text('host'), Text(host)]),
          Row(children: [Text('pwd admin'), Text(pwdAdmin)]),
          Row(children: [Text('altro account'), Text(altroAccount)]),
          Row(children: [Text('ultimo agg.'), Text(ultimoAgg)]),
          Row(children: [Text('data ultimo c.'), Text(dataUltimoC)]),
          Row(children: [Text('ora ultimo c.'), Text(oraUltimoC)]),
          Row(children: [Text('versione'), Text(versione)]),
          Row(children: [Text('server'), Text(server)]),
*/
