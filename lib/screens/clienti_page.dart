import 'package:farmagest/data/constants.dart';
import 'package:farmagest/provider/tcp_connection.dart';
import 'package:farmagest/screens/elenco_farmacie.dart';
import 'package:farmagest/widgets/switch_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientiPage extends ConsumerStatefulWidget {
  const ClientiPage({super.key});

  @override
  ConsumerState<ClientiPage> createState() => _ClientiPageState();
}

class _ClientiPageState extends ConsumerState<ClientiPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tcpConnection = ref.read(dnsConnectionProvider.notifier);

    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Clienti",
              style: TextStyle(
                color: kAmberRed,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: kLightBrown2,
        ),
        body: Container(
          color: kLightBrown, // Assicura che il colore di sfondo riempia tutto
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 40),
                        Text(
                          kClientiCerca,
                          style: TextStyle(
                            color: kAmberRed,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        SearchBar(
                          leading: Icon(Icons.search),
                          hintText: "Cerca farmacia",
                          controller: _searchController,
                        ),
                        SizedBox(height: 40),
                        SwitchRow(titlo: kClientiSoloFarm),
                        SwitchRow(titlo: kClientiSoloAttivi),
                        SwitchRow(titlo: kClientiGestTorino),
                        SizedBox(height: 40),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    tcpConnection.sendMessage(kRiceFarma);
                                    List<dynamic> fullJson =
                                        await tcpConnection
                                            .getFullResponseAsList();

                                    //print(fullJson);
                                    //todo
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder:
                                            (context) => ElencoFarmacie(
                                              farmaciaDati: fullJson,
                                            ),
                                      ),
                                    );

                                    /*
                                     List<dynamic> fullJson =
                            await tcpConnection.getFullResponseAsList();

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (ctx) => AgendaDetailPage(
                                  data: formattedDate,
                                  agendaDati: fullJson,
                                ),
                          ),
                        );
                                    */
                                  }, //scanBarcode,
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                      kLightBrown,
                                    ),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
