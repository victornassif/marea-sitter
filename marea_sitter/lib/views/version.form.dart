import 'package:flutter/material.dart';
import 'package:marea_sitter/models/version.model.dart';
import 'package:marea_sitter/repository/version.repository.dart';
import 'package:marea_sitter/routes/app.routes.dart';

class VersionForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = new Map<String, String>();

  void _loadFormData(Version version) {
    _formData['title'] = version.title;
    _formData['description'] = version.description;
    _formData['id'] = version.id.toString();
  }

  @override
  Widget build(BuildContext context) {
    final Version version =
        ModalRoute.of(context).settings.arguments as Version;

    _loadFormData(version);

    return Scaffold(
      appBar: AppBar(
        title: Text('Versão de Robô'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cloud_upload),
            onPressed: () {
              var isValid = _formKey.currentState.validate();
              if (isValid) {
                _formKey.currentState.save();
                if (version.id != null && version.id != 0) {
                  VersionRepository().updateVersion(Version(
                      description: _formData['description'],
                      title: _formData['title'],
                      id: version.id));
                } else
                  VersionRepository().createVersion(
                    Version(
                        title: _formData['title'],
                        description: _formData['description']),
                  );
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _formData['title'],
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value.isEmpty) return 'O campo não pode estar vazio';
                  return null;
                },
                onSaved: (val) => _formData['title'] = val.trim(),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                initialValue: _formData['description'],
                validator: (value) {
                  if (value.isEmpty) return 'O campo não pode estar vazio';
                  return null;
                },
                onSaved: (val) => _formData['description'] = val.trim(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
