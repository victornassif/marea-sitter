import 'package:flutter/material.dart';
import 'package:marea_sitter/models/behavior.model.dart';
import 'package:marea_sitter/repository/behavior.repository.dart';

class BehaviorForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = new Map<String, String>();

  void _loadFormData(Behavior behavior) {
    _formData['title'] = behavior.title;
    _formData['description'] = behavior.description;
    _formData['id'] = behavior.id.toString();
  }

  @override
  Widget build(BuildContext context) {
    final Behavior behavior =
        ModalRoute.of(context).settings.arguments as Behavior;

    _loadFormData(behavior);

    return Scaffold(
      appBar: AppBar(
        title: Text('Comportamentos'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cloud_upload),
            onPressed: () {
              var isValid = _formKey.currentState.validate();
              if (isValid) {
                _formKey.currentState.save();

                if (behavior.id != null && behavior.id != 0) {
                  BehaviorRepository().updateBehavior(Behavior(
                    description: _formData['description'],
                    title: _formData['title'],
                    id: behavior.id
                  ));
                } else
                  BehaviorRepository().createBehavior(
                    Behavior(
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
