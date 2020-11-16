import 'package:flutter/material.dart';
import 'package:marea_sitter/routes/app.routes.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
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
          ListTile(
            trailing: Icon(Icons.details),
            title: Text(
              'versões',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.HOME);
            },
          ),
          ListTile(
            trailing: Icon(Icons.details),
            title: Text(
              'comportamentos',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.BEHAVIOR_LIST);
            },
          )
        ],
      ),
    );
  }
}
