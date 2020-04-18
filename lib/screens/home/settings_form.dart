import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/services/database.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/shared/constant.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugarValue = ['0', '1', '2', ' 3', '4', '5'];
  String _currentName;
  String _currentSugar;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    final userLoggedIn= Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: userLoggedIn.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData){
          UserData userData = snapshot.data;
          return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Update Your settings',
                      style: TextStyle(
                          fontSize: 20.0,
                          letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      initialValue: userData.name,
                      decoration: textInputDecoration,
                      validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(height: 20.0),
                    //selecting preferred sugars
                    DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: _currentSugar ?? userData.sugars,
                      items: sugarValue.map((sugar) {
                        return DropdownMenuItem(
                          child: Text('$sugar Sugar(s)'),
                          value: sugar,
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentSugar=val),
                    ),
                    Slider(
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      min: 100,
                      max: 900,
                      divisions: 8,
                      activeColor: Colors.brown[_currentStrength ?? userData.strength],
                      inactiveColor: Colors.lime[_currentStrength ?? userData.strength],
                      onChanged: (val) => setState(() => _currentStrength = val.round()),
                    ),
                    RaisedButton.icon(
                        onPressed: () async{
                          if(_formKey.currentState.validate()) {
                            await DatabaseService(uid: userData.uid).updateUserData(
                                _currentSugar ?? userData.sugars,
                                _currentName ?? userData.name,
                                _currentStrength ?? userData.strength
                            );
                            Navigator.pop(context);
                          }
                        },
                        icon: Icon(Icons.straighten),
                        label: Text(
                          'Update',
                          style: TextStyle(color: Colors.grey),
                        ))
                  ],
                )
            );
        } else {
          return LoadingSpinKit();
        }
      }
    );
  }
}
