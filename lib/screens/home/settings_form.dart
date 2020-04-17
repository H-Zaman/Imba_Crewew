import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/shared/constant.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugarValue = ['0', '1', '2', '4', '5'];
  String _currentName;
  String _currentSugar;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text(
              'Update Your settings',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              decoration: textInputDecoration,
              validator: (val) => val.isEmpty ? 'Please enter a name' : null,
              onChanged: (val) => setState(() => _currentName = val),
            ),
            SizedBox(height: 20.0),
            //selecting prefered sugars
            DropdownButtonFormField(
              decoration: textInputDecoration,
              value: _currentSugar ?? '0',
                items: sugarValue.map((sugar) {
                  return DropdownMenuItem(
                      child: Text(sugar),
                      value: sugar,
                  );
                }).toList(),
                onChanged: (val) => setState(() => _currentSugar=val),
            ),
            Slider(
              value: (_currentStrength ?? 100).toDouble(),
              min: 100,
              max: 900,
              divisions: 8,
              activeColor: Colors.brown[_currentStrength ?? 100],
              inactiveColor: Colors.lime[_currentStrength ?? 100],
              onChanged: (val) => setState(() => _currentStrength = val.round()),
            ),
            RaisedButton.icon(
                onPressed: () async{
                  print(_currentName);
                  print(_currentSugar);
                  print(_currentStrength);
                },
                icon: Icon(Icons.straighten),
                label: Text(
                  'Update',
                  style: TextStyle(color: Colors.grey),
                ))
          ],
        )
    );
  }
}
