import 'dart:async';
import 'package:flutter/material.dart';
import 'package:marea_sitter/components/navbar.widget.dart';
import 'package:marea_sitter/components/version.tile.widget.dart';
import 'package:marea_sitter/models/version.model.dart';
import 'package:marea_sitter/repository/version.repository.dart';

class VersionList extends StatefulWidget {
  @override
  _VersionListState createState() => _VersionListState();
}

Future<Null> _handleRefresh() async {
  await getData();
}

getData() async {
  var list = await VersionRepository().getAllVersions();
  _streamController.add(list);
}

final _streamController = StreamController<List<Version>>.broadcast();

class _VersionListState extends State<VersionList> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'versões',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            tooltip: 'Refresh',
            icon: Icon(Icons.refresh),
            onPressed: _handleRefresh,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed('/version-form', arguments: Version());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
            stream: _streamController.stream,
            builder: (ctx, snp) {
              if (snp.hasData) {
                return buildListView(snp.data);
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blue[100],
                  ),
                );
              }
            }),
      ),
    );
  }
}

buildListView(List<Version> versions) {
  return RefreshIndicator(
    onRefresh: _handleRefresh,
    child: ListView.builder(
      itemCount: versions == null ? 0 : versions.length,
      itemBuilder: (BuildContext ctx, int index) {
        return VersionTile(versions[index]);
      },
    ),
  );
}
