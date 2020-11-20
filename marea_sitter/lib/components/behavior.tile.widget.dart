import 'package:flutter/material.dart';
import 'package:marea_sitter/models/behavior.model.dart';
import 'package:marea_sitter/repository/behavior.repository.dart';
import 'package:marea_sitter/routes/app.routes.dart';

class BehaviorTile extends StatelessWidget {
  final Behavior behavior;

  const BehaviorTile(this.behavior);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(behavior.title),
      subtitle: Text(behavior.description),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.BEHAVIOR_FORM,
                  arguments: behavior,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.black,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text('Excluir Comportamento'),
                          content: Text('Confirma exclusão do Comportamento?'),
                          actions: [
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Não'),
                            ),
                            FlatButton(
                              onPressed: () {
                                BehaviorRepository()
                                    .deleteBehavior(behavior.id);
                                Navigator.of(context).pop();
                              },
                              child: Text('Sim'),
                            )
                          ],
                        ));
              },
            )
          ],
        ),
      ),
    );
  }
}
