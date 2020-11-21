import 'package:flutter/material.dart';
import 'package:marea_sitter/components/alwaysDisableFocus.widget.dart';
import 'package:marea_sitter/models/dispatch.model.dart';
import 'package:marea_sitter/models/version.model.dart';
import 'package:marea_sitter/repository/dispatch.repository.dart';

class DispatchForm extends StatefulWidget {
  final Version version;

  DispatchForm({this.version});

  @override
  _DispatchFormState createState() => _DispatchFormState();
}

class _DispatchFormState extends State<DispatchForm> {
  final _formKey = new GlobalKey<FormState>();
  double qtd = 0;

  @override
  Widget build(BuildContext context) {
    // final Version version = ModalRoute.of(context).settings.arguments as Version;

    final Dispatch dis = Dispatch(versionId: this.widget.version.id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'despache',
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
                DispatchRepository().createDispatch(dis);
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
                initialValue: widget.version.title,
                focusNode: AlwaysDisabledFocusNode(),
                enableInteractiveSelection: false,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: 'Versão',
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Quantidade de robôs',
                textAlign: TextAlign.start,
              ),
              Slider(
                value: qtd,
                onChanged: (newRating) {
                  setState(() {
                    qtd = newRating;
                    dis.quantity = newRating.toInt();
                  });
                },
                onChangeEnd: (newRating) {
                  dis.quantity = newRating.toInt();
                },
                label: qtd.toStringAsFixed(0),
                divisions: widget.version.estoqueDisponivel,
                min: 0,
                max: widget.version.estoqueDisponivel.toDouble(),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
