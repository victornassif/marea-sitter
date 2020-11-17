import 'package:flutter/material.dart';
import 'package:marea_sitter/routes/app.routes.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

String rotaAtual;

class _NavBarState extends State<NavBar> {
  List<ListTile> getLists() {
    List<ListTile> listTile = List<ListTile>();

    AppRoutes()
        .getAll()
        .where((element) => element.route != rotaAtual)
        .forEach((val) {
          listTile.add(
            ListTile(
              trailing: Icon(Icons.details),
              title: Text(
                val.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(val.route);
              },
            ),
          );
    });

    return listTile;
  }

  @override
  Widget build(BuildContext context) {
    rotaAtual = ModalRoute.of(context).settings.name;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.width * 0.3,
            child: DrawerHeader(
              child: Text(
                'menu',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
          ),
          ...getLists()
        ],
      ),
    );
  }
}
