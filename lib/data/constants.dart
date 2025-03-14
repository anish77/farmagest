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
String kRiceAgenda = 'riceagenda: ';
String kFarmacia = 'Borga';
const kAggiornoBbs = 'aggiorna_bbsinfo:';
const kOk = 'ok';
const kErr = 'err:';
String kSoloFarmParafarm = 'FDPC';
String kSoloAttivi = 'A';
String kSoloGestTorino = ' GUBR';

String kCercaFarmacia(
  kFarmacia,
  isSoloFarmParafarm,
  isSoloAttivi,
  isSoloGestTorino,
) {
  if (isSoloFarmParafarm == false) {
    kSoloFarmParafarm = '';
  }
  if (isSoloAttivi == false) {
    kSoloAttivi = '';
  }
  if (isSoloGestTorino == false) {
    kSoloGestTorino = '';
  }
  String kRiceFarma =
      'riceditt: [["","$kFarmacia","$kSoloFarmParafarm,$kSoloAttivi,$kSoloGestTorino,"],"DI",["D1","D2","N11","N13","N2","N2A","N2B","N3","N4","N5"]]';

  return kRiceFarma;
}

String kAggiornaBBS(String userId, String psw, String file) {
  String kAggiornamento =
      '$kAggiornoBbs ["$userId ","$psw",[ ["AGGIPART","$file","                                                            "]] ]';
  return kAggiornamento;
}

//Info
const kInfoLogin = 'farmaconsult uso interno';
const kClientiCerca = 'Indicare il nome del cliente';
const kClientiSoloFarm = 'solo farmacie e paraf.';
const kClientiSoloAttivi = 'solo attivi';
const kClientiGestTorino = 'solo gestiti da torino';
const kAggPart = 'agg. part.';
const kUserid = 'userid';
const kPwd = 'password';
const kHost = 'host';
const kPwdAdmin = 'pwd admin';
const kAltroAccount = 'altro account';
const kUltimoAgg = 'ultimo agg.';
const kDataUltimoC = 'data ultimo c.';
const kOraUltimoC = 'ora ultimo c.';
const kVersione = 'versione';
const kServer = 'server';

//Colors
const kWhite = Color.fromARGB(255, 241, 239, 241);
const kLightBrown = Color.fromARGB(255, 228, 197, 140);
const kLightBrown2 = Color.fromARGB(255, 247, 230, 198);
const kAmberRed = Color.fromARGB(255, 179, 62, 20);
const kAmberRed2 = Color.fromARGB(255, 112, 32, 3);
