import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:farmagest/data/constants.dart';
import 'package:farmagest/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  Future<void> getDeviceInfo() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      kDeviceModel =
          'Android ${androidInfo.version.release}'; //kDeviceVerRelease
      kDeviceVerRelease = androidInfo.model;

      print(
        "main ----------- $androidInfo, ----- $kDeviceVerRelease, ----- $kDeviceModel",
      );
    } else if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      kDeviceVerRelease = 'iPhone${iosInfo.systemVersion}';
      kDeviceModel = iosInfo.model;
    }
  }

  @override
  Widget build(BuildContext context) {
    getDeviceInfo();
    return MaterialApp(
      //theme: theme,
      home: const LoginPage(),
    );
  }
}
