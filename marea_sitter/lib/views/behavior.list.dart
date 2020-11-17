import 'package:flutter/material.dart';
import 'package:marea_sitter/components/behaviorcard.widget.dart';
import 'package:marea_sitter/components/navbar.widget.dart';
import 'package:marea_sitter/models/behavior.model.dart';
import 'package:marea_sitter/repository/behavior.repository.dart';

class BehaviorList extends StatefulWidget {
  @override
  _BehaviorListState createState() => _BehaviorListState();
}

class _BehaviorListState extends State<BehaviorList> {
  var list = BehaviorRepository().getAllBehaviors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Comportamentos de Robôs'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed('/behavior-form', arguments: Behavior());
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

ListView buildListView(List<Behavior> behaviors) {
  return ListView.builder(
    itemCount: behaviors == null ? 0 : behaviors.length,
    itemBuilder: (BuildContext ctx, int index) {
      return BehaviorCard(behaviors[index]);
    },
  );
}
