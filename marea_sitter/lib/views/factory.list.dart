import 'dart:async';
import 'package:flutter/material.dart';
import 'package:marea_sitter/components/factory.tile.widget.dart';
import 'package:marea_sitter/models/factory.model.dart';
import 'package:marea_sitter/models/version.model.dart';
import 'package:marea_sitter/repository/factory.repository.dart';

class FactoryList extends StatefulWidget {
  Version version;

  FactoryList({this.version});

  @override
  _FactoryListState createState() => _FactoryListState();
}

Future<Null> _handleRefresh(versionId) async {
  await getData(versionId);
}

getData(versionId) async {
  var list = await FactoryRepository().getFactorysFromVersionId(versionId);
  _streamController.add(list);
}

final _streamController = StreamController<List<Factory>>.broadcast();

class _FactoryListState extends State<FactoryList> {
  @override
  void initState() {
    getData(widget.version.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'linha de produção',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            tooltip: 'Refresh',
            icon: Icon(Icons.refresh),
            onPressed: () => _handleRefresh(widget.version.id),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: _streamController.stream,
          builder: (ctx, snp) {
            if (snp.hasData) {
              return buildListView(snp.data, widget.version.id);
            } else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue[100],
                ),
              );
            }
          }),
    );
  }
}

buildListView(List<Factory> factorys, versionId) {
  return RefreshIndicator(
    onRefresh: () => _handleRefresh(versionId),
    child: ListView.builder(
      itemCount: factorys == null ? 0 : factorys.length,
      itemBuilder: (BuildContext ctx, int index) {
        return FactoryTile(factorys[index]);
      },
    ),
  );
}
