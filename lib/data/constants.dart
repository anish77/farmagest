import 'dart:ui';

//riceagenda: [["07/03/25"]]
const kPort = 1045;
const kIp = 'app.farmaconsult.it';
const kAppVer = 'Farmagest 1.9.8.1';
String kCodice = 'farma';
String kPassword = 'zeffir';

String kDeviceId = '';
String kDeviceModel = '';
String kDeviceVerRelease = '';
String kDeviceDisp = '';

String kLogin =
    "login: ['$kCodice','$kPassword','$kAppVer','B0173E3B-07D8-4419-8FC1-6623D5104F1F','iPhone13,2','17.6.1','',''] ";
String kLogOut = 'quit:';
String kRicercaAgenda = 'riceagenda: ';

//Info
const kInfoLogin = 'farmaconsult uso interno';
const kClientiCerca = 'Indicare il nome del cliente';
const kClientiSoloFarm = 'solo farmacie e paraf.';
const kClientiSoloAttivi = 'solo attivi';
const kClientiGestTorino = 'solo gestiti da torino';

//Colors
const kWhite = Color.fromARGB(255, 241, 239, 241);
const kLightBrown = Color.fromARGB(255, 228, 197, 140);
const kLightBrown2 = Color.fromARGB(255, 247, 230, 198);
const kAmberRed = Color.fromARGB(255, 179, 62, 20);
const kAmberRed2 = Color.fromARGB(255, 112, 32, 3);
