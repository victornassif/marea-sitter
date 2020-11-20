import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marea_sitter/components/behavior.tile.widget.dart';
import 'package:marea_sitter/components/navbar.widget.dart';
import 'package:marea_sitter/models/behavior.model.dart';
import 'package:marea_sitter/repository/behavior.repository.dart';

class BehaviorList extends StatefulWidget {
  @override
  _BehaviorListState createState() => _BehaviorListState();
}

Future<Null> _handleRefresh() async {
  await getData();
}

getData() async {
  var list = await BehaviorRepository().getAllBehaviors();
  _streamController.add(list);
}

final _streamController = StreamController<List<Behavior>>.broadcast();

class _BehaviorListState extends State<BehaviorList> {
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
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'comportamentos',
          style: TextStyle(color: Colors.black),
        ),
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
                  .pushNamed('/behavior-form', arguments: Behavior());
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

buildListView(List<Behavior> behaviors) {
  return RefreshIndicator(
    onRefresh: _handleRefresh,
    child: ListView.builder(
      itemCount: behaviors == null ? 0 : behaviors.length,
      itemBuilder: (BuildContext ctx, int index) {
        return BehaviorTile(behaviors[index]);
      },
    ),
  );
}
