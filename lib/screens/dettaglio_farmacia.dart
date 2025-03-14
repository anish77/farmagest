import 'package:farmagest/data/constants.dart';
import 'package:farmagest/provider/tcp_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DettaglioFarmacia extends ConsumerStatefulWidget {
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
  ConsumerState<DettaglioFarmacia> createState() => _DettaglioFarmaciaState();
}

class _DettaglioFarmaciaState extends ConsumerState<DettaglioFarmacia> {
  final TextEditingController _aggiornamento = TextEditingController();
  String transformData(String inputDate) {
    // Parsing la stringa in un oggetto DateTime
    DateTime dateTime = DateTime.parse(inputDate);
    // Formattare la data nel formato "gg-MM-aa"
    String formattedDate = DateFormat("dd-MM-yy").format(dateTime);
    return formattedDate;
  }

  String _inviaAggiornamento(String file) {
    if (widget.userId.isNotEmpty &&
        widget.password.isNotEmpty &&
        file.isNotEmpty) {
      return kAggiornaBBS(widget.userId, widget.password, file);
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final tcpConnection = ref.read(dnsConnectionProvider.notifier);

    return Scaffold(
      backgroundColor: kLightBrown2,
      appBar: AppBar(title: Text(widget.nome)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 120, child: Text(kAggPart)),
                SizedBox(
                  width: 200,
                  child: TextField(
                    textCapitalization: TextCapitalization.characters,
                    controller: _aggiornamento,
                  ),
                ), // Larghezza fissa
              ],
            ),
            Row(
              children: [
                SizedBox(width: 120, child: Text(kUserid)),
                Text(widget.userId),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 120, child: Text(kPwd)),
                Text(widget.password),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 120, child: Text(kHost)),
                Text(widget.host),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 120, child: Text(kPwdAdmin)),
                Text(widget.pwdAdmin),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 120, child: Text(kAltroAccount)),
                Text(widget.altroAccount),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 120, child: Text(kUltimoAgg)),
                Text(widget.ultimoAgg),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 120, child: Text(kDataUltimoC)),
                Text(transformData(widget.dataUltimoC)),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 120, child: Text(kOraUltimoC)),
                Text(widget.oraUltimoC),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 120, child: Text(kVersione)),
                Text(widget.versione),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 120, child: Text(kServer)),
                Text(widget.server),
              ],
            ),

            ElevatedButton(
              onPressed: () async {
                tcpConnection.sendMessage(
                  _inviaAggiornamento(_aggiornamento.text),
                );
                await tcpConnection.getResponse(context);
              },
              child: Text("Invia aggiornamento"),
            ),
          ],
        ),
      ),
    );
  }
}
