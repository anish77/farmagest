import 'package:farmagest/data/constants.dart';
import 'package:farmagest/provider/tcp_connection.dart';
import 'package:farmagest/screens/elenco_farmacie.dart';
import 'package:farmagest/widgets/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientiPage extends ConsumerStatefulWidget {
  const ClientiPage({super.key});

  @override
  ConsumerState<ClientiPage> createState() => _ClientiPageState();
}

class _ClientiPageState extends ConsumerState<ClientiPage> {
  final TextEditingController _searchController = TextEditingController();

  bool isFarmParaf = true; // Stato iniziale dello switch
  bool isAttivi = true; // Stato iniziale dello switch
  bool isSoloTorino = true; // Stato iniziale dello switch
  final _timer = TimerWidget();

  @override
  void initState() {
    super.initState();
    final tcpConnection = ref.read(dnsConnectionProvider.notifier);
    _timer.resetInactivityTimer(
      context,
      tcpConnection,
    ); // Avvia il timer quando l'app viene aperta // Avvia il timer quando l'app viene aperta
  }

  @override
  void dispose() {
    _searchController.dispose();
    _timer.inactivityTimer?.cancel();
    super.dispose();
  }

  void handleSwitchChange(String filter, bool value) {
    setState(() {
      if (filter == kClientiSoloFarm) {
        isFarmParaf = value;
      } else if (filter == kClientiSoloAttivi) {
        isAttivi = value;
      } else if (filter == kClientiGestTorino) {
        isSoloTorino = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tcpConnection = ref.read(dnsConnectionProvider.notifier);

    return GestureDetector(
      onTap: () => _timer.onUserInteraction(context, tcpConnection),
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

                        customSwitchRow(
                          context,
                          kClientiSoloFarm,
                          isFarmParaf,
                          (value) {
                            handleSwitchChange(kClientiSoloFarm, value);
                          },
                        ),
                        customSwitchRow(context, kClientiSoloAttivi, isAttivi, (
                          value,
                        ) {
                          handleSwitchChange(kClientiSoloAttivi, value);
                        }),
                        customSwitchRow(
                          context,
                          kClientiGestTorino,
                          isSoloTorino,
                          (value) {
                            handleSwitchChange(kClientiGestTorino, value);
                          },
                        ),
                        SizedBox(height: 40),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  height: 45,
                                  child: customButton(tcpConnection, context),
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

  Widget customSwitchRow(
    BuildContext context,
    String filter,
    bool selectedValue,
    ValueChanged<bool> onChanged,
  ) {
    return Row(
      children: [
        Text(
          filter,
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(color: kAmberRed),
        ),
        Spacer(),
        Switch(
          value: selectedValue,
          onChanged: (value) {
            onChanged(
              value,
            ); // 🔥 Notifica il genitore passando il nuovo valore
          },
          activeColor: Colors.green, // Colore della pallina quando è attivo
          inactiveThumbColor:
              Colors.white, // Colore della pallina quando è disattivo
          inactiveTrackColor: kAmberRed2,
        ),
      ],
    );
  }

  ElevatedButton customButton(
    TcpConnectionNotifier tcpConnection,
    BuildContext context,
  ) {
    return ElevatedButton(
      onPressed: () async {
        tcpConnection.sendMessage(
          kCercaFarmacia(
            _searchController.text,
            isFarmParaf,
            isAttivi,
            isSoloTorino,
          ),
        );
        List<dynamic> fullJson = await tcpConnection.getFullResponseAsList();
        if (!context.mounted) return;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ElencoFarmacie(farmaciaDati: fullJson),
          ),
        );
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(kLightBrown),
        side: WidgetStateProperty.all(BorderSide(color: kAmberRed, width: 2.0)),
      ),
      child: Text('Cerca', style: (TextStyle(color: kAmberRed, fontSize: 20))),
    );
  }
}
