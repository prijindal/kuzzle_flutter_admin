import 'package:flutter/material.dart';

class AddEnvironmentPage extends StatefulWidget {
  _AddEnvironmentPageState createState() => _AddEnvironmentPageState();
}

class _AddEnvironmentPageState extends State<AddEnvironmentPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hostController = TextEditingController();
  final TextEditingController _portController =
      TextEditingController(text: "7512");
  bool _sslValue = false;

  void _addNewEnvironment() {
    print(_formKey.currentState.validate());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("New Environment"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: "Name"),
                controller: _nameController,
                keyboardType: TextInputType.text,
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a host';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: "Host"),
                controller: _hostController,
                keyboardType: TextInputType.url,
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a port';
                  }
                  var parsed = int.parse(value);
                  if (parsed < 0 || parsed > 65535) {
                    return 'Port can only be between 0 and 65535';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: "Port"),
                controller: _portController,
                keyboardType: TextInputType.numberWithOptions(
                  signed: false,
                  decimal: false,
                ),
              ),
              CheckboxListTile(
                value: _sslValue,
                onChanged: (newvalue) {
                  setState(() {
                    _sslValue = newvalue;
                  });
                },
                title: Text("Use SSL"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  child: Text("Create"),
                  onPressed: _addNewEnvironment,
                ),
              ),
            ],
          ),
        ),
      );
}
