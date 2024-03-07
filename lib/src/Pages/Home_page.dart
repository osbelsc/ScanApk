import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scannn/src/Pages/zpages.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:scannn/src/bloc/scans_bloc.dart';
import 'package:scannn/src/providers/db_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QrScan'),
        backgroundColor: Color.fromARGB(255, 40, 107, 101),
        elevation: 1.0,
        actions: [
          TextButton(
            child: Icon(Icons.delete),
            onPressed: () => scansBloc.borrarScanTodos(),
          )
        ],
      ),
      body: _callPage(currentIndex),
      floatingActionButton: _buttonCloud(scansBloc),
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

_buttonCloud(ScansBloc scansBloc) {
  return FloatingActionButton(
    backgroundColor: Color.fromARGB(255, 40, 107, 101),
    onPressed: () {
      _scanQr(scansBloc);
    },
    child: Icon(Icons.qr_code_scanner_sharp),
  );
}

Future<String?> _scanQr(ScansBloc scansBloc) async {
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
    scansBloc.agregarScan(scan);
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
