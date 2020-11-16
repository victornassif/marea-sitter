import 'package:flutter/material.dart';
import 'package:marea_sitter/models/version.model.dart';
import 'package:marea_sitter/repository/version.repository.dart';

class Versions with ChangeNotifier {
  final List<Version> _versions = VersionRepository().getAllVersions().then((value) => value.toList()) as List<Version>;

  List<Version> get all{
    return [..._versions];
  }

  int get count{
    return _versions.length;
  }
}
  
  
  