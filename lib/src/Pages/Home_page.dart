import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scannn/src/Pages/zpages.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:scannn/src/providers/db_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QrScan'),
        backgroundColor: Color.fromARGB(255, 40, 107, 101),
        elevation: 1.0,
        actions: [Icon(Icons.delete)],
      ),
      body: _callPage(currentIndex),
      floatingActionButton: _buttonCloud(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 41, 87, 83),
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                label: 'Maps',
                icon: Icon(
                  Icons.map,
                )),
            BottomNavigationBarItem(
                label: 'Directions',
                icon: Icon(
                  Icons.cloud,
                ))
          ]),
    );
  }
}

_buttonCloud() {
  return FloatingActionButton(
    backgroundColor: Color.fromARGB(255, 40, 107, 101),
    onPressed: () {
      _scanQr();
    },
    child: Icon(Icons.qr_code_scanner_sharp),
  );
}

Future<String?> _scanQr() async {
  //https://github.com/osbelsc
  //
  String? cameraScanResult = "https://github.com/osbelsc";
  // try {
  //   cameraScanResult = await scanner.scan();
  // } catch (e) {
  //   cameraScanResult = e.toString();
  // }
  //

  if (cameraScanResult != null) {
    final scan = ScanModel(valor: cameraScanResult);
    DBProvider.db.nuevoScan(scan);
  }
}

_callPage(int actPage) {
  switch (actPage) {
    case 0:
      return MapaPage();
    case 1:
      return DireccionPage();
    default:
      return Container(
        decoration: BoxDecoration(color: Colors.redAccent),
        child: Text('Error page'),
      );
  }
}
