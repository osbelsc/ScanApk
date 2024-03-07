import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scannn/src/bloc/scans_bloc.dart';
import 'package:scannn/src/providers/db_provider.dart';

class MapaPage extends StatelessWidget {
  final scansBloc = new ScansBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ScanModel>>(
        stream: scansBloc.scansStream,
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
            itemBuilder: (context, i) => Dismissible(
              onDismissed: (direction) =>
                  scansBloc.borrarScan(scans[i].id ?? 0),
              background: Container(
                color: Colors.red,
              ),
              key: UniqueKey(),
              child: ListTile(
                leading: Icon(
                  Icons.cloud,
                  color: Color.fromARGB(255, 40, 107, 101),
                ),
                title: Text(scans[i].valor ?? 'Valor predeterminad'),
                subtitle: Text("ID: ${scans[i].id ?? 0}"),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Color.fromARGB(255, 40, 107, 101),
                ),
              ),
            ),
          );
        });
  }
}
