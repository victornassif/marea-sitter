import 'package:flutter/material.dart';
import 'package:marea_sitter/routes/app.routes.dart';
import 'package:marea_sitter/views/factory.carousel.dart';
import 'package:marea_sitter/views/factory.form.dart';
import 'package:marea_sitter/views/factory.list.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AppRoutes.FACTORY_CAROUSEL,
      routes: {
        AppRoutes.FACTORY_CAROUSEL: (_) => FactoryCarousel(),
        AppRoutes.FACTORY_FORM: (_) => FactoryForm(),
        AppRoutes.FACTORY_LIST: (_) => FactoryList(),
        AppRoutes.VERSION_LIST: (_) => VersionList(),
        AppRoutes.VERSION_FORM: (_) => VersionForm(),
        AppRoutes.BEHAVIOR_FORM: (_) => BehaviorForm(),
        AppRoutes.BEHAVIOR_LIST: (_) => BehaviorList(),
      },
    );
  }
}
