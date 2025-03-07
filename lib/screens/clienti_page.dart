import 'package:farmagest/data/constants.dart';
import 'package:farmagest/widgets/switch_row.dart';
import 'package:flutter/material.dart';

class ClientiPage extends StatefulWidget {
  const ClientiPage({super.key});

  @override
  State<ClientiPage> createState() => _ClientiPageState();
}

class _ClientiPageState extends State<ClientiPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                                  onPressed: () {}, //scanBarcode,
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
