import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scannn/src/providers/db_provider.dart';

class MapaPage extends StatelessWidget {
  const MapaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ScanModel>>(
        future: DBProvider.db.getTodosScans(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final scans = snapshot.data;
          if (scans!.length == 0) {
            return Center(
              child: Text('No existe Info'),
            );
          }
          return ListView.builder(
            itemCount: scans!.length,
            itemBuilder: (context, i) => ListTile(
              leading: Icon(
                Icons.cloud,
                color: Color.fromARGB(255, 40, 107, 101),
              ),
              title: Text(scans[i].valor ?? 'Valor predeterminad'),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Color.fromARGB(255, 40, 107, 101),
              ),
            ),
          );
        });
  }
}
