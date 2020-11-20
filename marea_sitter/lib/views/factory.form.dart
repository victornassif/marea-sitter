import 'package:flutter/material.dart';
import 'package:marea_sitter/models/factory.model.dart';
import 'package:marea_sitter/models/version.model.dart';
import 'package:marea_sitter/repository/factory.repository.dart';

class FactoryForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Version version =
        ModalRoute.of(context).settings.arguments as Version;

    final Factory fac = Factory(versaoId: version.id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'fabricação',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cloud_upload),
            onPressed: () {
              var isValid = _formKey.currentState.validate();

              if (isValid) {
                _formKey.currentState.save();
                FactoryRepository().createFactory(fac);
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
                initialValue: version.title,
                focusNode: AlwaysDisabledFocusNode(),
                enableInteractiveSelection: false,
                decoration: InputDecoration(
                  labelText: 'Modelo',
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Tempo estimado da fabricação (minutos)',
                ),
                validator: (value) {
                  final n = int.tryParse(value);
                  if (n == null)
                    return '"$value" não é um numero válido. Insira um número inteiro';
                  return null;
                },
                onSaved: (val) => fac.tempoConclusao = int.parse(val),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Quantidade robôs'),
                validator: (value) {
                  final n = int.tryParse(value);
                  if (n == null)
                    return '"$value" não é um numero válido. Insira um número inteiro';
                  return null;
                },
                onSaved: (val) => fac.quantidadeRobos = int.parse(val),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
