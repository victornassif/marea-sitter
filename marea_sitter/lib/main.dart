import 'package:flutter/material.dart';
import 'package:marea_sitter/provider/versions.provider.dart';
import 'package:marea_sitter/routes/app.routes.dart';
import 'package:marea_sitter/views/versions.carousel.dart';
import 'package:provider/provider.dart';
import 'package:marea_sitter/views/behavior.form.dart';
import 'package:marea_sitter/views/behavior.list.dart';
import 'package:marea_sitter/views/version.form.dart';
import 'package:marea_sitter/views/version.list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Versions(),
        ),
        // ChangeNotifierProvider(
        //   create: (ctx) => Versions(),
        // )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: AppRoutes.HOME,
        routes: {
          AppRoutes.HOME: (_) => VersionCarousel(),
          AppRoutes.VERSION_LIST: (_) => VersionList(),
          AppRoutes.VERSION_FORM: (_) => VersionForm(),
          AppRoutes.BEHAVIOR_FORM: (_) => BehaviorForm(),
          AppRoutes.BEHAVIOR_LIST: (_) => BehaviorList(),
        },
      ),
    );
  }
}
