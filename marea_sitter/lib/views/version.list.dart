import 'package:flutter/material.dart';
import 'package:marea_sitter/components/navbar.widget.dart';
import 'package:marea_sitter/components/versions.card.dart';
import 'package:marea_sitter/models/version.model.dart';
import 'package:marea_sitter/repository/version.repository.dart';

class VersionList extends StatefulWidget {
  @override
  _VersionListState createState() => _VersionListState();
}

class _VersionListState extends State<VersionList> {
  var list = VersionRepository().getAllVersions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Versões de Robôs'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed('/version-form', arguments: Version());
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: list,
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
    );
  }
}

ListView buildListView(List<Version> versions) {
  return ListView.builder(
    itemCount: versions == null ? 0 : versions.length,
    itemBuilder: (BuildContext ctx, int index) {
      return VersionCard(versions[index]);
    },
  );
}
