import 'package:flutter/material.dart';
import 'package:marea_sitter/models/version.model.dart';
import 'package:marea_sitter/repository/version.repository.dart';
import 'package:marea_sitter/routes/app.routes.dart';

class VersionTile extends StatelessWidget {
  final Version version;

  const VersionTile(this.version);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(version.title),
      subtitle: Text(version.description),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.orange,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.VERSION_FORM[0],
                  arguments: version,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text('Excluir Versão'),
                          content: Text('Confirma exclusão da Versão?'),
                          actions: [
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Não'),
                            ),
                            FlatButton(
                              onPressed: () {
                                VersionRepository().deleteVersion(version.id);
                                
                                Navigator.of(context).pop();
                                Navigator.of(context).pushReplacementNamed(AppRoutes.VERSION_LIST[0]);
                                
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
